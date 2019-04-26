From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Date: Fri, 26 Apr 2019 11:09:07 -0300
Message-ID: <20190426140907.GB22086@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423105303.61683-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jolsa@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Apr 23, 2019 at 12:53:03PM +0200, Thomas Richter escreveu:
> An -ENOMEM error is not reported in the GTK GUI.
> Instead this error message pops up on the screen:
> 
> [root@m35lp76 perf]# ./perf  report -i perf.data.error68-1
> 
> 	Processing events... [974K/3M]
> 	Error:failed to process sample
> 
> 	0xf4198 [0x8]: failed to process type: 68

Thanks, applied to perf/urgent.

- Arnaldo
