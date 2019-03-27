From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf: Add duration_time to perf stat
Date: Wed, 27 Mar 2019 20:51:37 +0100
Message-ID: <20190327195137.GC17944@krava>
References: <20190326221823.11518-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326221823.11518-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 26, 2019 at 03:18:19PM -0700, Andi Kleen wrote:
> Currently it's not possible to get the wall clock time of a measurement
> in CSV mode output, it's only in the non CSV perf stat output.
> Often this is needed to normalize event counts to time.
> 
> Add a new duration_time event that can be specified and reports
> the wall clock time in ns.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
