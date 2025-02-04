/*
 * powersave.c
 *
 * Copyright (C) 2011 - 2024 Sebastian Gottschall <s.gottschall@dd-wrt.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
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
#ifdef HAVE_POWERSAVE
#include <stdlib.h>
#include <ddnvram.h>
#include <shutils.h>
#include <utils.h>
#include <syslog.h>
#include <signal.h>
#include <services.h>

void start_powersafe(void)
{
	if (nvram_matchi("powersave", 1)) {
		dd_loginfo("powersave", "Ondemand CPUFrequency scaler Enabled");
		sysprintf("echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor");
	} else {
		dd_loginfo("powersave", "Performance CPUFrequency scaler Enabled");
		sysprintf("echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor");
	}
	return;
}
#endif
