From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf unwinding - wrong stack pointer register value?]
Date: Thu, 15 Nov 2018 11:00:28 -0800
Message-ID: <8736s2xj1v.fsf@linux.intel.com>
References: <2335309.gnWok9HYb4@agathebauer> <31474933.dcNFsqGoRn@agathebauer>
        <CAOBGo4wPeobp90eqZF1apZxHUn-dnh6L3Rpt_=beR49o3XHY7g@mail.gmail.com>
        <6310843.N4ooJGWzKY@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6310843.N4ooJGWzKY@agathebauer> (Milian Wolff's message of "Thu,
        15 Nov 2018 10:10:13 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Travis Downs <travis.downs@gmail.com>, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> I agree. I personally like your suggested approach - only add an indication 
> when the IP differs so much that it points to a different function. What do 
> others say to this?

Yes that's fine.

-Andi
