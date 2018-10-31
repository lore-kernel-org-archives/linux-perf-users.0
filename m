From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
Date: Wed, 31 Oct 2018 17:28:52 -0200
Message-ID: <20181031192852.GD6669@redhat.com>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org>
 <s5hlg6ehwzk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hlg6ehwzk.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Oct 31, 2018 at 06:00:47PM +0100, Takashi Iwai escreveu:
> On Wed, 31 Oct 2018 17:44:57 +0100,
> Arnaldo Carvalho de Melo wrote:
> > 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To silence this perf build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> >   diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> > 
> > Due to this cset:
> > 
> >   a98401518def ("ALSA: timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'")
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Link: https://lkml.kernel.org/n/tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Thanks for the correction.
> 
> That's bad to have duped files that have to be synced manually...

There is an advantage, we get warnings about changes that could entail
changes in the tools, also it has happened in the past that changes made
in the kernel end up breaking the tools/ build, so the synch should be
done carefully.

Also we don't want to add to the workload of kernel developers.

> At least, some checkpatch addition would help to suggest always
> correct both places?

I think not having it is better.

- Arnaldo
