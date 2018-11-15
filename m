From: Travis Downs <travis.downs@gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Wed, 14 Nov 2018 21:05:32 -0500
Message-ID: <CAOBGo4wPeobp90eqZF1apZxHUn-dnh6L3Rpt_=beR49o3XHY7g@mail.gmail.com>
References: <2335309.gnWok9HYb4@agathebauer> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
 <20181112032637.GG6218@tassilo.jf.intel.com> <31474933.dcNFsqGoRn@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31474933.dcNFsqGoRn@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: ak@linux.intel.com, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Nov 14, 2018 at 8:20 AM Milian Wolff <milian.wolff@kdab.com> wrote:

> 3) I suggest we always keep the first frame and sample IP from the user regs,
> i.e. the accurate PEBS/IBS IP. Then we add the following frames from unwinding
> the ustack with the iregs.

Does this mean that the displayed unwind will sometimes be
"impossible" to have actually be generated from a consistent execution
of the user program?

For example, the top frame (from PEBS) and second frame (from iregs)
may be inconsistent in that the latter function never calls the first.
At this point it would be good to have an indication at the top frame
is from a different source than the rest of the frames, lest the user
pull is hair out trying to determine how function X seems to call
function Y despite that not being the case in the source.
