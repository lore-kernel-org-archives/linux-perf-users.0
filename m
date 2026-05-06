Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70464BC018
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087556; cv=pass; b=TKQ20W+7nHel+BdGO6rHSfe6rRqIVbYMhWnusUHVmCjJZAo28OXGErLHDiBRGpSMcUjuKpBzdkoZH67EZ7Tm+EzSROF7dfHajaxkaVk+SVHQUznOcNWKu9exN4Dc9CYchRARVJjo/P55913YInWcricvmnbBH+g3yn/Im6TQIKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087556; c=relaxed/simple;
	bh=17IZaLORx4Vx9au5q6osCbPBFXBcBs4/XURatHyIo7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8GXO49NZOI7ZmeHknMe6KKlQym8d6pkRKPCicWkdYj+PsfrfGBDGmyhHBwbQ3k7YjRL3hLbD0/X8vREOsNnVrLyI69zrvc2lW3SZFhj7rJNPd7EoOrb8eg/vGwYg6YCNPyBxl2x+428VrCYQkaa2LmRW2ItJhrMstSC0MA6Ig4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pT2IRC2e; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pT2IRC2e"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso124975ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 10:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778087540; cv=none;
        d=google.com; s=arc-20240605;
        b=eEdoK3jOEuBQLsF+UiWYC3LfzPTVgdzLLttCeWI7Ms0enGBS3n/WNldXXKr0Zo0K8K
         9WBgHyQFoREa2ta6pgCUC4Yn/aAh0yHb2qfmC9HBjvcyZTndECrEixSDqqOMqBTxh6Xn
         ICOUolXn/dGBbUKBO439dCNnlqo+nAIKhq06USPXN16NUKaLU9tAxFYuc4hBr8kO+b+8
         L5eTay8MelhaxPNIgjLEvkE/Ozwp1ARSGXadsg4N6gZ3Sve6WwAlg6QBzok+whXH+dst
         ov4ukMVaBSI6w1Qs53KeLF6MY4sNlXijo8VWMxm+ElXDlFJkixkwvZ7UIwwwx4reCIMr
         Q/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gdLoyAXbTHg5MUYYwlWwe/g+DURTsJ0015s5KHfP6M8=;
        fh=kXUt0O1iu1bXFrGzJOJq+kDx+GjqiOLX16IwRRUWkos=;
        b=hXcFLmBtspVsicnWSFcuWzbfSrkrufJyYIf3qUoBlEGHf3RpX8waZj6Kj9L9+pVYGu
         0OhSegRwGEKZ2OaMNROQmmBCM1Pzsjr6k6CdgiucvkuBdMpB2T/l+oAntOZMG8arFCGu
         STPIyqz1FQGxIoMVjzeXErNj+ahDKnyVgv7d3KckXQDeH8RyO78sBt2goEbvctCyPhLF
         5p8KYwvojtpcoG2/8FlXPS18HIlzTD9z61qPr+OW9obw6laComYnKoO6Cxys9foqGOhu
         snqdT2ni5+1sMQlUsJt6xa8SdkfaD6zFq2kmjI97UXAc+l2FY9IhiNgyPZnFw/wDjCeJ
         M8bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778087540; x=1778692340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdLoyAXbTHg5MUYYwlWwe/g+DURTsJ0015s5KHfP6M8=;
        b=pT2IRC2edN5mixihI8CHMSUB6CfWyd8hRzSeP/uzakExz3hnZJmQxC2lQX7p8vgi75
         QuNFAbLTly8R+KqoNvHLRpcpx9zNULtKtVWgPIU1tr91B3Q3dKFJ2Qk2yutlMTsjL/yA
         rWpGPQkj905kYOH0ZN7lflK9BEalyK2lyKYJ1q7cD8wf4iGLXgcTTlYES4wawxRrM0wj
         pKGMK88KjC8ePqqVgHGXMoFOYAx7SAdNyHXfmv130howK6RYub7A42xQrpzC/7kBB4BA
         xGIXHeZps48hh2RdYmmTfSj8KflcTYlMbz0XMZDdtn4YFuFUt5rrVXut+n6osxtb7oYC
         bf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778087540; x=1778692340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdLoyAXbTHg5MUYYwlWwe/g+DURTsJ0015s5KHfP6M8=;
        b=TgH0PdQmSMrtKNnoA59xSHmSzDBEvcgDjbgTsDdJYvynSW3qDIIaogOLXknSmBed5u
         /oLlOZqWG/z+i/PP2S5K4TKG/ayX50AnWYv2UBvmyKANot3k1k9TedqbGGgqWEjkBO5F
         Akfol9D6amkSr+TsoPeQTc5oKph6NZQkfiPk3xBuJwU+v0152a3rQMGjevrROxM5jcUr
         TuRH28aa8Hm6L19Blk/E7Gc7mdfhQRDwX5wp8c6aMv245J4FaVRnDlUpTspNyyW6QZL3
         UCeGJmci5eM05Jr7cGh0dtz5OT14CpSztkEHDvkba3gn2CcVqAq+FIP03WzU8u7IcIOd
         G1ow==
X-Forwarded-Encrypted: i=1; AFNElJ8BAmIsCgnm1gDdSKg74Q9wlTSUWSeCBSBzi/M6oCUZ8ZzccJdGEBGo/JcLwiIwWBNqDihAX7Vnjjkk4V5rk1hz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PmI5k6eX9doWY3yUsnwgYlHlE9Nau+LW2wrdiB3wLcV7Y5Ow
	wBEFW6FYqPCjN+4gJFpQDlPQ3NedYO4+QkPtjBI7+pw+XRNuhafMkLiBUzFF8HR1mv/8HP6D701
	HmjHzja0TAl6kekYP39egzyb4n7ABCqdX8Tm1XpRV
X-Gm-Gg: AeBDiev7wZt46opc8FtyvSal+vs3FJ9okqZHFgtSkr2knV7Jh4gdIPrQTJaElG8NVcy
	LryZc0D35Qkix6JPMgy/bqEuV4fPdt3Rm0e2bYXbE+bG0EFa5+nQCu4gaSR655WwtfCJqkErXbs
	GfuDbWA5TB63eDLxv0iU/tg4+Rv4sPbDBe9D140Le7G2v8BCqVZ/nPzAkYtVnwkR+X3NFhcZI4W
	rbc+t5TmowmZV30HVmlhL//eKGvoC7+jRiK2yHmOnrrSz7YUccHU89dGIcr++6v6QZH2EjYFgCO
	lPO/LSMMMghFzD5cUCTSvNe/TZ3QOAIjRkacR39h/yepkkZwkB3wWHtxKgI=
X-Received: by 2002:a17:903:124b:b0:2b9:a39a:e5db with SMTP id
 d9443c01a7336-2bab63fdaeemr38015ad.7.1778087539764; Wed, 06 May 2026 10:12:19
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321061448.810525-1-irogers@google.com> <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com> <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
 <adPzEmwDaHq4SsZw@google.com> <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>
 <afs9tx6hpi9CiEzN@x1> <aftpmFmahaykG7Rg@google.com>
In-Reply-To: <aftpmFmahaykG7Rg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 May 2026 10:12:05 -0700
X-Gm-Features: AVHnY4JZ7-urFSmGnOWKaanXHlPtrHLlMOwgmkcusVivLUN54g7Xy5M5z6J1KhE
Message-ID: <CAP-5=fUuF4LpSMy30AuLoz-wKy9O8ZLkh+UWBrDJTwNV-D=eqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 9:17=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, May 06, 2026 at 10:10:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 05, 2026 at 02:56:02PM -0700, Ian Rogers wrote:
> > > On Mon, Apr 6, 2026 at 10:53=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > > On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> > > > > On Thu, Apr 2, 2026 at 7:42=E2=80=AFPM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > > > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > > > > > On Thu, Mar 26, 2026 at 4:20=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > > > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > > > > > Doing a `perf sched record` then `perf sched stats report=
` crashes as
> > > > > > > > > the tp_handler isn't set. Add extra checks that tp_handle=
r is set
> > > > > > > > > before accessing through it.
> >
> > > > > > > > Oh.. unintended use case. :)  Probably better to add a dumm=
y handler
> > > > > > > > for `perf sched stats report`.
> >
> > > > > > > Perhaps. I'd prefer to land the simpler change as-is.
> >
> > > > > > Well.. I guess the dummy handler approach would be simpler and =
perform
> > > > > > better. :)
> >
> > > > > > +++ b/tools/perf/builtin-sched.c
> > > > > > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv=
)
> > > > > >                 .switch_event       =3D replay_switch_event,
> > > > > >                 .fork_event         =3D replay_fork_event,
> > > > > >         };
> > > > > > +       struct trace_sched_handler stats_ops  =3D {};
> > > > >
> > > > > Oh, because there's an existing null test on the function pointer=
 we
> > > > > don't need dummy functions, which is what I thought you were aski=
ng
> > > > > for. I'm still not convinced this is very intention revealing, bu=
t if
> > > > > it works for you then you can have my reviewed-by tag.
> >
> > > > Applied this and the patch 2 to perf-tools-next, thanks!
> >
> > > Thanks Namhyung. Did this get accidentally dropped? I'm not seeing it
> > > in perf-tools-next.
>
> I think I've applied my approach and test fix.

Ok, that wasn't clear. I think it is good to post such changes to the
list. For example, just sync-ing the header files prompted sashiko to
point out a bug in our beauty scripts:
https://lore.kernel.org/linux-perf-users/20260504193334.9F978C2BCB8@smtp.ke=
rnel.org/

Thanks,
Ian

> Thanks,
> Namhyung
>
