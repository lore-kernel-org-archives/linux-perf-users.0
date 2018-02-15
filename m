From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: Fix test case inet_pton to accept inlines.
Date: Thu, 15 Feb 2018 11:50:00 -0300
Message-ID: <20180215145000.GA26423@kernel.org>
References: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Feb 14, 2018 at 08:03:03AM +0100, Thomas Richter escreveu:
> Using Fedora 27 and latest Linux kernel the test case
> trace+probe_libc_inet_pton.sh fails again on s390.
> This time is the inlining of functions which does not match.
> After an update of the glibc (from 2.26-16 to 2.26-24)
> the output is different

Thanks, applied.

- Arnaldo
