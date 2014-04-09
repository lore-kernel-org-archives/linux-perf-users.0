From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Correctly handle symbols in VDSO
Date: Wed, 9 Apr 2014 18:13:10 +0200
Message-ID: <20140409161310.GB19506@krava.brq.redhat.com>
References: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com>
 <87eh19y8cm.fsf@sejong.aot.lge.com>
 <3C60FB26-A78B-4E37-B4A6-E6F7283CEB4C@tbricks.com>
 <20140408154101.GA21094@krava.brq.redhat.com>
 <A7CC2084-4F71-436C-9AEC-394F66A4981E@tbricks.com>
 <20140409153546.GA19506@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140409153546.GA19506@krava.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Nikulichev <nvs@tbricks.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 09, 2014 at 05:35:46PM +0200, Jiri Olsa wrote:
> On Wed, Apr 09, 2014 at 10:46:13AM +0400, Vladimir Nikulichev wrote:
> > Hi,
> > 
> > On Apr 8, 2014, at 7:41 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > hi,
> > > could you please put explanation from first email
> > > into the patch changelog?
> > > 
> > > cc-ing lkml
> > > 
> > > thanks,
> > > jirka
> > 
> > 
> > OK, pasting it together:
> 
> ook
> 
> hum, your email's encoding kills my 'git am' :-\
> also 'perf tools: Adjust symbols in VDSO' should go into the
> email subject
> 
> I processed this patch by hand this time

actually I'll have to ask you to resend your patch
with proper subject and coding, refer to:
  https://www.kernel.org/doc/Documentation/email-clients.txt

  "Emailed patches should be in ASCII or UTF-8 encoding only."

Please CC lkml (linux-kernel@vger.kernel.org). Strangely enough,
I don't see your patch there at the moment.. 

thanks,
jirka
