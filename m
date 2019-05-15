From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf docu: Add description for stderr
Date: Wed, 15 May 2019 16:32:17 -0300
Message-ID: <20190515193217.GG23162@kernel.org>
References: <20190513080220.91966-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513080220.91966-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, May 13, 2019 at 10:02:20AM +0200, Thomas Richter escreveu:
> Perf report displays recorded data on the screen and emits
> warnings and debug messages in the status line (last one on screen).
> Perf also supports the possibility to write all debug messages
> to stderr (instead of writing them to the status line).
> This is achieved with the following command:
> 
>  # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
>  # ll /tmp/2
>  -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
>  #

Thanks, applied.

- Arnaldo
