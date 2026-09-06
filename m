Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD77357CFC
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728720; cv=pass; b=i1/g+BdBBqUulQ9yegtxWKYu7iNRkT5xKWcagygYCFgsLiVxLXImQievqHceW9y+ICDRoL/dQtKtmNMzSIF5fNmsgYXS3aCpbizmJgsDnAZOXhdW7qPW36GFxByE3VpUpr8zkLY3YU2GJIYEM6vf8IksucZAjrFF63OcJ8b7/2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728720; c=relaxed/simple;
	bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMAG81tTEYVwfrYq/QTG4dCTjhICP+vLmdDFOSlUEopUBDbLJPRY+IPWfU0+UOSmTe4u0jaYplEPHfCrKWDW5D+200FE7bpkm0BwJPrIsS8kBdbYLAaVB4bGcAlGMcR1D2dwC1/14YSKpPwKyFRMdE5yLTttFsdwuRN7t8fHek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyN7SpfW; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyN7SpfW"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so2274917e87.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 14:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728717; cv=none;
        d=google.com; s=arc-20260327;
        b=PJ3Pc6MoHNpNx0aZKDvb/iMx+z5ZcDkQKgCS1t2fmvLEaXkA/54JnSBILUEXhAY/yX
         0K4zn3N85aPU85T+un3rrvV3oJxu04W4DzfwBfaL3sRzv8ymYIt3xezHjKdyIJBGjyUG
         CfNxk64RiHFjKZ8kEG7sC/DeZmlXVkDTDDRizKRIsfLwE0HH/E/88YUz32XvA1QnWMcw
         zVe1zAa0iRzmH2eA+DzCbKk2MYWOaBWhouDGmnvIGoJbtePVIRtOJz4PhxfvQJ4/5eZQ
         MK6iAV1xkUC1N+9DKzGl/9COcEuZV/FW1kEYdTHuqPF0mwIcOU4vFDk0Uzsg4wj5tUve
         zu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        fh=1S/5yoiI8PP3mGVBmdrfnzBz2K7rbO7BaRW/1n03IP4=;
        b=j9n+/dUyR09hOktprtSvLiN3cUxhxdM5XfvQ9eJ1CoTVF8YF7qnUY8TZ9ieTtOa3Av
         FyZ5vVs1ypCMyD4JtLjBakJ36N+OFdh7PnER5xAY09HjIoGCbhxnChjEST5GFcQgQGTv
         mHhCK5NIL9Nz7roe4EYKYUxUw+/HBKQpcPzj+NoarLSN4hQ5FHxOrNynwbLtqWTNLDzr
         uP0uAemjg3M6wMFxjT2GmHICgv9elXwQkyMeJunI+Qdorz+sgMyGt61Q+yEIVpgxORMv
         PnX+9OMFbPvOeBx5gnNkIXh9FbFBCMk7aMPIQ3gM8Pu+ft6H53WD1phUKATBGhPbXgcM
         LiPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728717; x=1789333517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        b=FyN7SpfW9h3+bE2nMZiuDWVATRRrWw3/o7h5822dQC2S3YC7H3gT0ScGmPKfXg4yDk
         CaIdJpQjp0WSxNbBK3PGHqq+lPLKx1tuFLRBLygSG2zcmBZbCgslicizB6T9NbrOOkaV
         bHWzywyN0MVfVPpbUWY34SWVmIAybed+z/i2nrTH1dfkEWICKZlxlp4/LIU6dIC1RlK5
         1WSZsogR2O6PaDzz5lwuJcpaRye91gfExnp5+Tbk4WGCVZQwKzQWGh9keHJZx42NNwZR
         ofShlcFPM+3JiJifM4YbIeZSupAI3ZDEjAl0wxAtnWO3J4Az8KQewbUNmefOppOkF63A
         YK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728717; x=1789333517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        b=TSBkYX1OxXPi7Ci9kMPpYfjQZMYx4Fh8lsTNCyMuQ5uG87Uo/VUQl9S2g/t7bZzo84
         BcDAqrTloBwgjTLv7wOUYV+PhHJWJC/F0JxLYyiAV4sTnUl6f0yaS9DVTdgvRmzoMn3G
         YM7lQtrCS9N8LAd9AOZqSS/HAw7vBMxIis7HOBa/J7CuIj3vHG2eK49d/dUd+IKyVnCp
         HEbRdiGD8XE8Av3lr3bx15aAWCHq+aTfhmM8yw0i+0NgXRMw5wE+DIuXb9x6v1La2pzR
         8Kexi3SaNn69/x/kEx60B0iK9dH0CgB5E0XU8e2TnpzKro0mSgaUaCYF3/W/inUCtjQZ
         7mYA==
X-Forwarded-Encrypted: i=1; AKwUvBzjoFiRY+AzeAzRtUaKkgQpz+Ugl3rmQdUNA4dxXbVJUvTGG2Q26awxIMx0vMaG+S2k/FXdBnqmuN/1/+Ki/ZlS@vger.kernel.org
X-Gm-Message-State: AFuF++mjnsiuzYAwVTZrSUqWZzFVRovs1JW+DSigPEKcUugqrEQCrCYk
	vwns2brh5OjbwCyK/4H/b1NdZjNkPgSnBTerbDFrjQVmk66ayq0XZcMkDTPzsYrSlEMQ65Zda2G
	ivTDOkUsgvAPJBgc384QA+G0GlWbUMbw=
X-Gm-Gg: AYBFou3iyX2nHMT1MlC67+8iPD8z11Zguz/MN3sHZfk36zCeq+bxBGXTDXavrCGeve7
	6D6qWQ/5pmdjCxZUfygDjoP3WTtA9dBvuGYUQlvdqh3DQLfJomrpa1+C8++82ppA3pdPQ5vgXd2
	48r4BHU5JU4keSH36FeWZUxeSSS+I7UUZ4gZ9AmX0eX5eQBKLnuKLsWhmKKQmXg/OK9jYRDPTS7
	oxorJlNrozz774JWGTBaIXyy7r2Mn3zj6Bm0iJ1FCRhFX06p3I8R+fuBRLccKoq6GfVUgN8VoY+
	6Kh2XW5fZLPGXcLy3vDOiDGVyeohNkltw2FyEixz2C4JkraZHo3VJcWR0MM+jXoqksA9TOMp9aJ
	Sprg=
X-Received: by 2002:a05:6512:2521:b0:5b4:9fba:dc6c with SMTP id
 2adb3069b0e04-5b616f09015mr2983243e87.15.1788728716688; Sun, 06 Sep 2026
 14:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com> <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
In-Reply-To: <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 Sep 2026 17:05:04 -0400
X-Gm-Features: AcwNN1VfE32-AxkuqqKFXwQZBnRH9Q5ktj20CyevInVOMud57lXIeFkz6ak6xcc
Message-ID: <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 4:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com> w=
rote:
> >
> > GTK2 is long dead upstream and increasingly hard to keep building on
> > current distros. This series ports perf's GTK-based report browser to
> > GTK4 and fixes it up so it's actually loadable at runtime after the
> > port.
> >
> > Patch 1 does the mechanical port (build system, widget API changes),
> > including the leftover-GTK2-call and signal-handling fixes that were a
> > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > port that prevented the browser from loading. Patch 3 fixes two stack
> > buffer overflows in the hierarchy view that predate the port.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > Changes in v7:
>
> Matt, please stop the spam.
> Wait for humans to reply before respinning.
> 7 revisions in one day is way too much.

My apologies. I figured it would actually save humans time if I went
ahead and addressed all the sashiko-generated feedback. Dunno.

Is there a way to get feedback from sashiko without mailing the public list=
?
