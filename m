From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Date: Thu, 23 Aug 2018 18:00:26 -0500
Message-ID: <20180823180026.06e2e4dbca8954207f5ecf07@arm.com>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?UTF-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, 23 Aug 2018 14:29:34 +0200
Martin Liška <mliska@suse.cz> wrote:

> The patch changes interpretation of:
> callq  *0x8(%rbx)
> 
> from:
>   0.26 │     → callq  *8
> to:
>   0.26 │     → callq  *0x8(%rbx)
> 
> in this can an address is followed by a register, thus
> one can't parse only address.
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---

Tested this doesn't incur any grievances parsing aarch64 code:

Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
