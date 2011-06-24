From: Arun Sharma <asharma@fb.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Thu, 23 Jun 2011 17:43:28 -0700
Message-ID: <4E03DDB0.3050502@fb.com>
References: <4E026123.4060208@fb.com> <4E034C2C.30509@gmail.com> <4E03968A.5010008@fb.com> <20110624001100.GD8058@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110624001100.GD8058@somewhere.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 6/23/11 5:11 PM, Frederic Weisbecker wrote:

>
> I'm confused, you first said it happens with new tools on older kernel.
>
> Can you tell us which combination of kernel/user raises the error? and
> which error.
>

perf-3.0 + 2.6.38

perf record -agR gives:

Can't find id 9's machine
Found 1 unknown events!

perf-3.0 + 2.6.32

perf record -ag
perf script

samples have bogus timestamps

perf-3.0 + 2.6.32

perf record -agR
perf script

error: Samples do not contain timestamps

perf-3.0 + any kernel

perf record -agT
perf script

is happy everywhere. Thanks!

  -Arun
