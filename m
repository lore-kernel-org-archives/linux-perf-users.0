From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Fri, 24 Jun 2011 02:11:03 +0200
Message-ID: <20110624001100.GD8058@somewhere.redhat.com>
References: <4E026123.4060208@fb.com>
 <4E034C2C.30509@gmail.com>
 <4E03968A.5010008@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E03968A.5010008@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Sharma <asharma@fb.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jun 23, 2011 at 12:39:54PM -0700, Arun Sharma wrote:
> On 6/23/11 7:22 AM, David Ahern wrote:
> 
> >I have not seen issues like this using newer perf userspace against
> >older kernels. For example, my laptop was running Fedora 14 (2.6.35) and
> >now Fedora 15 (2.6.38.8) and I typically use latest perf builds (e.g.,
> >testing patches).
> 
> I narrowed it down to PERF_SAMPLE_RAW:
> 
> perf record -ag -- sleep 1
> 
> is fine, but:
> 
> perf record -agR -- sleep 1
> 
> fails for me most of the time. The reason I needed to use the -R in
> the first place is that "perf script" fails on older kernels with:
> 
> Samples do not contain timestamps.
> 
> With the newer perf, I don't get errors, but the timestamp field is
> invalid. So I need to use the -R flag to get valid timestamps +
> stacktraces out of "perf script".

I'm confused, you first said it happens with new tools on older kernel.

Can you tell us which combination of kernel/user raises the error? and
which error.

Thanks!
