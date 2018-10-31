From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
Date: Wed, 31 Oct 2018 17:29:51 -0200
Message-ID: <20181031192951.GE6669@redhat.com>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org>
 <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Oct 31, 2018 at 10:27:02AM -0700, Joe Perches escreveu:
> On Wed, 2018-10-31 at 18:00 +0100, Takashi Iwai wrote:
> > On Wed, 31 Oct 2018 17:44:57 +0100,
> > Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > To silence this perf build warning:
> > > 
> > >   Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> > >   diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> > > 
> > > Due to this cset:
> > > 
> > >   a98401518def ("ALSA: timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'")
> > > 
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > Link: https://lkml.kernel.org/n/tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Thanks for the correction.
> > 
> > That's bad to have duped files that have to be synced manually...
> > At least, some checkpatch addition would help to suggest always
> > correct both places?
> 
> How could that work in checkpatch?

No need for changes.
 
> Wouldn't a symlink be simpler?

That would be equivalent to using it directly, see my response to
Takashi for a few of the reasons this is done this way.

- Arnaldo
