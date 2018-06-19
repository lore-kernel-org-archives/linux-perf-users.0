From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/3 v2] perf alias: Remove trailing newline when reading
 sysfs files
Date: Tue, 19 Jun 2018 12:13:49 -0300
Message-ID: <20180619151349.GG20477@kernel.org>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615101105.47047-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jun 15, 2018 at 12:11:03PM +0200, Thomas Richter escreveu:
> Remove a trailing newline when reading sysfs file contents
> such as /sys/devices/cpum_cf/events/TX_NC_TEND.
> This shows when verbose option -v is used.
> 
> Output before:
> tx_nc_tend -> 'cpum_cf'/'event=0x008d
> '/

Thanks, applied.

- Arnaldo
