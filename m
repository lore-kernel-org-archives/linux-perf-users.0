From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: Change warning for missing sysfs entry to
 debug
Date: Thu, 12 Apr 2018 14:22:52 -0300
Message-ID: <20180412172252.GF9818@kernel.org>
References: <20180412133246.92801-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180412133246.92801-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 12, 2018 at 03:32:46PM +0200, Thomas Richter escreveu:
> Using perf on 4.16.0 kernel on s390 shows warning
>    failed: can't open node sysfs data
> each time I run command perf record ... for example:

Thanks, applied.

- Arnaldo
