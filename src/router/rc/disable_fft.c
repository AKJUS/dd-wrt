/*
 * disable_fft.c
 *
 * Copyright (C) 2006 - 2025 Sebastian Gottschall <s.gottschall@dd-wrt.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 * $Id:
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <shutils.h>
#include <utils.h>

static int disable_fft_main(int argc, char **argv)
{
	if (daemon(0, 0)) {
		perror("daemonize failed");
		exit(1);
	}
	sleep(10);
	int i;
	int cnt = getdevicecount();
	for (i = 0; i < cnt; i++) {
		sysprintf("echo disable > /sys/kernel/debug/ieee80211/phy%d/ath9k/spectral_scan_ctl", i);
		sysprintf("echo disable > /sys/kernel/debug/ieee80211/phy%d/ath10k/spectral_scan_ctl", i);
		sysprintf("echo disable > /sys/kernel/debug/ieee80211/phy%d/ath11k/spectral_scan_ctl", i);
	}
	return 0;
}
