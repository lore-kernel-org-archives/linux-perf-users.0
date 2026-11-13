Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587743;
	b=qsIG6vc+GymJojS0Qo4X8B1DID9L99rnDTKRkGBedILRzcIHqcpPgyesOQ0WBGXsTVWU
	 XgGMLhVaW79KphsknJbTHbgR1mZWCWb1EFuT2uGtqIeHKuG5xgJ2QPsoejj3HegGbqEee
	 DMvwtWseOS16kmwdpVVRMuEaMNWWmHEtdVVlLwV6q2bgCvpZlafiBEFejcehhEsC6i85b
	 xqBF2Ow/Bp4LXw8ZRnNWXKTVoTgOHfKBQvU7p0iLRpRiLflBF4oA9FLbESRaCD8VbfCTN
	 HcU9p6/nFdSvWajKu75EfrGAh+ztyGtLRksTHwK09IM1qzVsUJXFmb66kZt4aaw7SnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6Wvtz9D6vgbM+u/1wpqOZ954b+KYcK1dv6Mh68QSbho=;
	b=edFVWSRUDHDWYMCist1P/+ZkIwibQS0UozqsWU9CfuRWTfrq4csmfFmtX+IHpshqbG5M
	 BdSOFFViXjQ6D05ycR4/cwgvSY303rV8xkurRrO2N/uhj26/4df05PRbAMGkFmZc2KtjZ
	 YGJgHwWPfdo5/L/r8z8KzA5NBD30MF4XRDJbASz2mKMdaVw7ya8c47TiN7TFMf44J99JW
	 E3/pWXZ6Gbilba0cCQivHN0xYh0KiJ9sAPSeffzW4yBdU0RrPOS/K4PMOBjM90tBJUp5l
	 rBvBUmL4HntZaXNxX9smbkof0cA8fDh/mWY2JUqDJ4pLJMMdB324GbCOWBj7lxsnYAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BzroyGQE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD1606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4CD1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BzroyGQE
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533202fe429so426051cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587742; cv=none;
        d=google.com; s=arc-20260327;
        b=JId8pMEe92kTCRPMIIY1cSKuqg68dLsVKsWW1I5OOrzza2bV8y0kKorqsY+7h3hQCZ
         e9ZvENmLngdDwudQpOphR50Z353tP2JVsyW6h6Bb33pwfiXrFvgmZkBNSCEqUBWAFPVH
         gsAIogHxR1onWps281VYAzOyfnOGXYqYtcrOoqih2V5N2MIYhIN7D/hG1MSZk01Jai4X
         Xk5VrnOXtCv4y7WfMQa8jYj/TDSWrMt005ItQlV5IGCq1VcS7I5VkpxMOGKjdwnVLckz
         +t/sLxXMtScrtHskh7T4t5eor38/kTRy+LzmSmRRdQnuVP/PUAr1hkOfbaMzm/VswJsa
         mSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Wvtz9D6vgbM+u/1wpqOZ954b+KYcK1dv6Mh68QSbho=;
        fh=ICMmbTdYDkgOi6gFN8p2imsUVlEFHmjO8QJrvbqiDtc=;
        b=YyVDmS4/QZlowmCs7CdFc2cXosM/rtraKOKEbw4gM9RB6rCDJIldVvAE9zk0CtbKxn
         ZBQ6YtUCQqdPQKlMCQSHuWBoF7wffwVcepRK8zmU2s2EGW4FTNISkptMEKuq07ZkkFge
         aWlzKKzsRFDyH/QtOgWJFKH+TG7H67ogKjJcDATNu26P62QtC78l6k6ewvTZBhs41zNs
         D4EOf8CYUKiLLVcvHj/X8PXZzH986aLsj5tANevaNFQq7Npq81b4MlyMF9AHBlGc+LXy
         SBGKNwmQHGO/DuBVySE2ffMT52/A+nALXEKi7nIQqfZPwUm7tUejeDos3FN6FEUfL2Oq
         rPNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587742; x=1795192542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Wvtz9D6vgbM+u/1wpqOZ954b+KYcK1dv6Mh68QSbho=;
        b=BzroyGQEclR38tAAhozFMMhmB0SRz6tvHPqBp2ub7NhpVkg5b3TfyLZB6azeiSWCLD
         4wmL32iW/VAp77UJ6xll9u5GhVL28v+7f56VEFjbp96HkyuSuU/Wzy08bfeV65iNcFO0
         n/7+klqKK37IdN0wCxzailjWpQL9VXtEmPdwfJbcQMA0YOtnSE2PDsDkC9sSzzjJmPvm
         CbnQmii0HGehhLl5qAAXYjIdHes0nheJzO17DhOp4drrc+0nP7iQ4zwhjYrs+E4K0mhi
         2Visqqnt/V7IL6+HmTLckQ8jbv7qb1hfWfnDUSGu0BwpFuGuOS3BhOPJHEnWgtAG+yzT
         rBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587742; x=1795192542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Wvtz9D6vgbM+u/1wpqOZ954b+KYcK1dv6Mh68QSbho=;
        b=Zjv+R9NAAQoMjcQb9Fyest+UfwE/ZCsmmkQcdvH3PQi+vOQye165BRj2Zwv8mU8knC
         TEfLo5NRHY6VSvpiRA3ZRkC/gtbj/UBvREi7pKx4mu4ab8Nhr794GQ0PVcqrxSIlD48+
         pqbc8UWLPZwjUzrNGaGHNvD1SdhPJdvkF5eIc7yPQzAsJETHexOvEYsBI01KEPh2QkqZ
         YCgdwmNnVQuR0kRDDW09RXwN1gvQvW3bKUtTecSUg5J2V3+u0VtTdnutFB3qu4fTjdky
         O6hH+W59zZkvsfaZrJLDIrWmDKxykGYIJ8istMU2lS+yEWannl0bcWhr4S5nie+9QRZN
         JLTA==
X-Forwarded-Encrypted: i=1; AL+hErE2R1aPc+H5K+3FR20FFgqrsW2Au6Hk9ohSzet+u2UtsiohZAX3W32EtPv3tdE/5aAkKPYxJAH5JokFuMaknshT@vger.kernel.org
X-Gm-Message-State: APuU4Z+HDqVB5MW2pEVFpuCaxS5s+KY+WhdraXdkgzAlcVoLOiBIxfuf
	og0RNzVCHToziR9x5xXgyNFMDjjcEy6dbDELO/XadVQIxKuSEQFbowPMxUz1VMeE3Wmc0nJMBU8
	fpI4shPq73UJkK8/OOxuDiCqlvm8I1da+SCp7HKhl
X-Gm-Gg: AYBFou2EdfJi543gWo8P1zJQC+XmbrNS/e9zAWX/g1mGg8XiMlavU7XHVhi5gn2F2bE
	JwV/AMrF+vfMO1bRm0QV52pdg6tJtGVG1//1XBpVY7E+XV+lQ4DOYNNnMEeM3blYgrrBMqTUzUm
	uJTu5tKet/ummmC8rZuFrSyuFFyj6k4Z9cI9QtL5MoUYsRiaAh/yLssvf5LFAR3iaBRsLILMTWf
	WEx+gR19bh6vLHPveJVulMWtF+E/V+VErZJkNO8nJanU3iufHFqN3Eg6wEA5z4FJ66rjFYT4ja+
	5UzhgLG1tPJ8k/BSLE1DbZ80tpClbxWt11RL6IXMg4MT5Zz9OYN5269N+ltDJW1ygIrRQFgb6Ru
	ND6SwioIeuU9pea8Q1zisYBq1wsGMPCLHAgORIquUFgrooImWlWrQUweoZxZoghiSgSJgeEb1G0
	/36Ki3aJje5SFq
X-Received: by 2002:a05:622a:4d9b:b0:536:78de:775f with SMTP id
 d75a77b69052e-55b44e0a79amr14925261cf.15.1794587741025; Fri, 13 Nov 2026
 08:35:41 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com> <20261111174213.3526604-17-irogers@google.com>
 <avVl_JNcFqq7sZvd@google.com>
In-Reply-To: <avVl_JNcFqq7sZvd@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 08:35:29 -0800
X-Gm-Features: AclHuK8PfQbklhmPM2_Vg84I7H9O-DXLd-KLmS3zmzOFzPck-cWzjRORBggtnwY
Message-ID: <CAP-5=fXFBqUgsC2Uug0BDBLg2Cg6O8C9ULF95j7kd7npeUhG5g@mail.gmail.com>
Subject: Re: [PATCH v12 16/20] perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 11, 2026 at 09:42:08AM -0800, Ian Rogers wrote:
> > Replace tpebs_mtx_get() and its pthread_once() initialization helper
> > tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> > control_fd and ack_fd.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/intel-tpebs.c | 91 +++++++++++++++--------------------
> >  1 file changed, 38 insertions(+), 53 deletions(-)
> >
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index 5cb090b27fbd..2edd8297fa1b 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -38,12 +38,12 @@
> >
> >  bool tpebs_recording;
> >  enum tpebs_mode tpebs_mode;
> > +static DEFINE_MUTEX(tpebs_mtx);
> >  static LIST_HEAD(tpebs_results);
> >  static pthread_t tpebs_reader_thread;
> >  static struct child_process tpebs_cmd;
> > -static int control_fd[2], ack_fd[2];
> > -static struct mutex tpebs_mtx;
> >  static struct cond tpebs_cmd_cond =3D { .cond =3D PTHREAD_COND_INITIAL=
IZER };
> > +static int control_fd[2] =3D { -1, -1 }, ack_fd[2] =3D { -1, -1 };
>
> Nit: I think it's better to split the line when they have initializers.

Done in v13 (along with folding in the __guarded_by(&tpebs_mtx)
annotations from the next patch).

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  static bool tpebs_stopping;
> >  static bool tpebs_enabled;
> >  static bool tpebs_cmd_in_flight;
