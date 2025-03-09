Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388142E822
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Mar 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741555200; cv=none; b=JIv93Us9xkxu3evhsFn8oMFhmfh5HbSWmH5iS4WRLAoNSfo6P2nctuEWCyqu4JSfpUcMp4E5r2gNzNxQcssgxQA+OzVWWz829LnSxns5h20/goYi4md5yPHd67689upFokdOrCNRPYGukrBxVcL89kZq5P1/TutH9/rswTfOswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741555200; c=relaxed/simple;
	bh=dtR5CVcOAvr3fjS6ELh01V1WmVDywwgTqyYVOdVtHP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMhxzeMAAtZ6yp0Iwzt8f0tm9TB/ybKS8UnY0NW0AEDv3zqGEsnC0pIWniEA+HzQyfWT67he1T0rHRGX0+7MrIdITD58OVPgXlcBRBLm8QGbKWI5kbmfGJlTcPpttcfsfkXSkbpycHjATPZAnPAw+pJUdbU+YhehELI0yt8eEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIiS1rp6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIiS1rp6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240aad70f2so156125ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Mar 2025 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741555198; x=1742159998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtR5CVcOAvr3fjS6ELh01V1WmVDywwgTqyYVOdVtHP0=;
        b=BIiS1rp65jwn4z3PaOWQ6CPbdV/nGuWYlSoGzi3De6kNtaGVf9x1NbBt1qX1AQVaVf
         CigpweDmkl29ssxvQLtnen+EpOdpK8vXh9Ids50NfMAgKOxMJDUUnQ41kd3MIhCvqHoM
         8jhXZS7KIasbW06UCUDExW2m3fVfg8LWKz9BJ7cGzz9o4eMy6HWUY2yZ3Xp1hCwB43h6
         xGjAcm08MCd7MlaRn6l67V2ZtSZgTiiA2fuVErixoiZ30w/FnzVG/drg+NVV9uUiO1D/
         d+F2TcTu7kHNkpvti2JAgoe87Q2G3B+PBtqazO5eCcrkh3FLeau1a/L3cfzFPSftVCWv
         1mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741555198; x=1742159998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtR5CVcOAvr3fjS6ELh01V1WmVDywwgTqyYVOdVtHP0=;
        b=A5vTEiwa4+m8A6szD6FbT8Lhkzx4dffykA9bqkYPOHHH9+I9AtrklPdgFRSDiLNKg/
         BGUdv/3sqVNAoY9FalcM3u3dRCTt3giXE+kmmwA1RixsrIOvibTB0EuVBP2klyanpL6u
         iRuoTU0BTvICOpTfNOThIQGO3L4faoiX4HrZSa6A+AgmXTkLbZNEEaBtNXnshbdQj2rz
         OX7x028PKd3Wch3sC0xL83EporWn03Mc8PYhcBjrtpR/DU0HGQnJN4EjweDKB6VJKgYa
         KssOlhLm88Bg/UrDZ79dFryzLR7rJQd7AtMxrlUOMDwmDzPIepizb5VGRptY6gn6Q10C
         qJiA==
X-Gm-Message-State: AOJu0YwtrSxor1jaJaqUhDxNaPw6jbwSW3oTM5AokIlSWFXfutSBoE4R
	M7hOzeXTJRXaFgwGCXubzoC70CMtPoQ7fc8PT9yOeLPl7MERZtCZ3trCWHSlE6OmY83KWbvC69B
	swMgSwmTTW3LzJKBO+e/lcXQV8Sy5EKXGxZb4
X-Gm-Gg: ASbGncuLjivHilaZpDXnMrG5RpGurSvrKps7gbwVcc6eSXqjDoUhj3abocAec1sze19
	F8SgwsCcydDaIAkKO2OPpuX2wkiGYvfQG0r9yoOoukr/8v2bo2aBm3uGvQSzFnnIhoImjIFFKw/
	Dc0rlWToONMJThLHe4hM+ZCpRW/VW1UzcyP3k5LQ==
X-Google-Smtp-Source: AGHT+IEJhR3+rAaQ++E8V7FlJFmxvewAFVWUxbni6Q/weWuILkW9h8lVbhaRFIAoOBCVNK4tn41KNeajHrpHSiTrwaw=
X-Received: by 2002:a17:903:1b6c:b0:216:4d90:47af with SMTP id
 d9443c01a7336-22547831402mr2023965ad.29.1741555198167; Sun, 09 Mar 2025
 14:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me> <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
In-Reply-To: <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 9 Mar 2025 14:19:46 -0700
X-Gm-Features: AQ5f1Jr0j4M0q4yr27RXXddbvVfIfIUCYvtAcp0Yo5MNNrZjrteczA0JQZhgbJs
Message-ID: <CAP-5=fUUn_VFKLjUV=VDby09oHRAbvUkWwheqO8Yq=7v56i12g@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To: Linux regressions mailing list <regressions@lists.linux.dev>, "to: Mark Rutland" <mark.rutland@arm.com>
Cc: Linux perf Profiling <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>, 
	"cc: Marc Zyngier" <maz@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 12:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Dec 6, 2023 at 4:09=E2=80=AFAM Linux regression tracking #update
> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > [TLDR: This mail in primarily relevant for Linux kernel regression
> > tracking. See link in footer if these mails annoy you.]
> >
> > On 22.11.23 00:43, Bagas Sanjaya wrote:
> > > On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> > >> Perf broke on all Apple ARM64 systems (tested almost everything), an=
d
> > >> according to maz also on Juno (so, probably all big.LITTLE) since v6=
.5.
> >
> > #regzbot fix: perf parse-events: Make legacy events lower priority than
> > sysfs/JSON
> > #regzbot ignore-activity
>
> Note, this is still broken. The patch changed the priority in the case
> that you do something like:
>
> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>
> but if you do:
>
> $ perf stat -e 'cycles' benchmark
>
> then the broken behavior will happen as legacy events have priority
> over sysfs/json events in that case. To fix this you need to revert:
> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> events over legacy"

This still hasn't been fixed and I'm at the point of saying I no
longer care except I want consistency. Let's revert the prioritization
of sysfs/json events for PMUs. I don't want to carry around patches
like:
https://lore.kernel.org/r/20240926144851.245903-2-james.clark@linaro.org
If this re-opens this bug then I'm fine with that, and I'm happy to
point to James and Arnaldo's comments [1] saying that somehow legacy
events are better, because drill down or something (what a bit pattern
has to do with that, no idea, we already default on Intel to
non-legacy events and drill down just dandily for topdown). Whatever,
I'm fed up with dealing with mine and others' comments being taken out
of context. I'm fed up with the ambiguity of two encoding systems, one
with and one without PMUs specified. I'm fed up with working on PMU
and event encoding, ordering, matching, metrics, etc. where it is
unclear what the behavior should be. I'm fed up with ARM choosing bad
uncore event names, refusing to correct them and creating a massive
mess they barely help clean up other than by largely reposting my
patches. I'm fed up that all of this was done for ARM and then they
don't seem to care about its resolution or testing the original
regression. Yes, this sucks as user land won't be able to be a source
for event configuration fixes. Yes, this sucks as such functionality
would slim down PMU drivers and was a behavior requested by RISC-V
face-to-face with a maintainer. I don't see why I should have to fight
for this other than I unexpectedly broke things in the first place
(this regression report) and I was trying to help RISC-V.

To be specific, I don't want the event 'instructions' be encoded as
type 'hardware' and config 'instructions', be reported as
'cpu_core/instructions/' but then that event to be encoded as type 4
(RAW) and config 0xc0.

The fact with this cpu-cycles will only wild card on core PMUs, but
cpu_cycles will wildcard on all of them. Again, why do I have to try
to fight for sanity, let's just back everything this regression report
created out. We check legacy events and do their behaviors, otherwise
we fall back on sysfs/json.

Thanks,
Ian

[1] https://lore.kernel.org/all/Z8sMcta0zTWeOso4@x1/
