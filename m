Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA911352C5B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633420; cv=pass; b=Yk++OaZiOokROOFi9Sc26eqQCshlmJL3lLKvBOnWreBerPNilFRIo7sBefRWYs4LPVZa7qcCUlU8/Iz8+tw/WO13BldYe11GIuBNBA+lBhAxofS1c1g1L3bHI7nP6JwhWIqiKRgvuEeNJLPobt0ovg1Y71yyColHfD8INwHHqJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633420; c=relaxed/simple;
	bh=Jgwdh8Y7o7kZvafx8ZBjwDIuhYxZfx7DmGCqgCggZSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+JzhG0xIA5wFy2u6O4jc3lpaRf2d7Rn4M3vDeHJJup9YYc+Un9UAw6s4QcvONAMWW/MFzzlmx0DSvMTFQrODwB3fm/AUf2yqY6/L91EYhH8QuuAaOznF9TE5ixnJDRhCEqFxv5CUK2/R5bl/uNF0BHbuX12KSUYrTSoI5OR0uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQfElID+; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQfElID+"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so5664c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775633419; cv=none;
        d=google.com; s=arc-20240605;
        b=RCn2dKkXXeZwg/2fjj4AFe5KyaPmbJHJESG7coiFVJOENmSYKHxUpZAtf+u8wHWzvl
         +HHI8cAaACJpx+odPaKHZc7eBBewv7VD54YV9IrGjxrcZd7s97Y+D6cSJLE+XYW3PbMI
         lClauDyBbvm+yAu/+c24iulJo84Y4CnGn5uGbOlAEgy7OkoMC0752AIefKadFxKTpZuj
         2Xd7eC9csrm6CRCAr8zyCAP5O0v3rBI6zFNVYVnREOr8k918Fa2yzBLOlUGnz88/KLox
         HMm0tca6ShEbbFBmnprpx1Asoik1uTjhecMJ02LgQDclIhvLGqEVlCASqlbrxRR2TQ8N
         p8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jgwdh8Y7o7kZvafx8ZBjwDIuhYxZfx7DmGCqgCggZSo=;
        fh=oi3EizLKf17zgiSxEwq83ojEIn2wUYI2yIC5XwvF4ws=;
        b=Xy7gBKUGsVljlnJ6e74u6xa3JVCOSu9e6WS+Xl8+XjPm0C191AkLdnUVhUfmtnXA2x
         SMyw0xh/H7iRO8eLuvPCQecBGC4pUtOZJK0a/7GqGQo+7gHZ2iZJm+K6pIRPRY9tTW4+
         cToFygbwYdrxoS9kxjkTV5eXMhNBnHJIH6NYcGtlunRV5Tm/xG+GwI4ATgSRrwpub6Jy
         XROeVxiZtCaaOt12zR1027uDzmcSybVtIg+ZsSDBIbT5hgdZWRYEnkhhW9VHgPhr/0Fm
         JUSKxunT3aBOcNXNYaAkFf7PYrOJpGuMtqKVVMXmW9BlG7UI3gMppazvQv3GUEt9G8OO
         hAZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633419; x=1776238219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgwdh8Y7o7kZvafx8ZBjwDIuhYxZfx7DmGCqgCggZSo=;
        b=bQfElID+QV69bldY3W6AS8D43+OxOlrk8b9B42tpsh2+e0JlxzCA3cuCQOqV8t/9Oc
         cSCPk7l9NX0+CZZ98KntIXvrQftwfshC7koSmJB3iW5RBLD8qDAvRNsCilmTx2/nNmoG
         CB5/kAfuvFDfLgsoBVGi3fTGn55+oziOuN6FeeXOWmRcGEZ6qRn6mNs0VuadbWQXpW1Q
         dGySsciXUo9/dXXuSXlIupaKLYe8hYYVRFRifqwo7LDbZS9vNleHXdghZI4LXru+t+zS
         nXqWzSidemuui7mm3x5ijc4+pbdxNWnSiZuQ3jL3zOUQ/LNP61btgDm9o2uRfgQddJwj
         tFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633419; x=1776238219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jgwdh8Y7o7kZvafx8ZBjwDIuhYxZfx7DmGCqgCggZSo=;
        b=LIOM0pfVRQtOuLQDncUBQFgqMkKQsKTL36fqDI6gKvdKsoHH/bTlJ0CVrfJM6rr771
         6McaU81uWhsEYEm41J3INhvyF6cbTHjkqp2gEHqbPAU1Ncqi9kPUgfjeQmrahXsXbcob
         PuxpHL1y+HMtAuvlsAkexb7sYgZDV9efpPaxWlXWi/vuEbxO+CSbnxFclE7HDcYBj38s
         b2bpq7o6e0AhUO4V1O3MzHRxiwFZyB3zoccHQZUfAlZOvNodK+eJUMC4ScFTolhlR2sc
         Ro93RfC5XyWSLgMqKUxthc/7j9ADrj8saOUMfVeRJAuirQtwPfHqESo2irmBYBFBOOti
         St6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4/bV4t0Wp4q1lW68RPvT560aRsiCTx7yD5bqfRLhJxYk7epbxKPF0LoTM1MeU0LLZJbGlsx4iZ3nr7aF/vmqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YypkLt6L5/GRDl1W2ckln3uzYwIb1G3BNOEf3pSBrmiDv1YTINh
	E0+Bh9ypv7lj6Aqa4jR2M4VcnzCw4chB4gNQkm0BrlK7b8rPbZ1TdTJjZ7YISy4CLw4HzO1ArmI
	26+Hg3v4Ie8jikUk4Z7964IYKKe51ek/6lBHXRC+8
X-Gm-Gg: AeBDiesyWz0+SplCZ9Gf+PRVM5piwcSFeLxO0A0E14HYwZrr4FjuAbByXHFbncHAorf
	9S7Y4rc7AjhN9ousF4VgJQGuvNcJbye8fRCNkY8S95V5/femrnnJv9Dn1ZrLRN3TSV/mGIdIvCp
	UtFVcEkXC+rRwUOXIKdc9bD9IWagxomkHXDKViAgoqgMFb+/0KyFLWDw7kZxOG46Sq1GoxWccPC
	Typ97anCHb2Jk2GfZ7NDUdjgEcoW7I08BsG90G2T0In8PesKiQ5cenWeskMustLvP9TRaOql+La
	AojCxKV3
X-Received: by 2002:a05:7022:220c:b0:11a:4c75:a45b with SMTP id
 a92af1059eb24-12c2151c692mr67825c88.10.1775633417986; Wed, 08 Apr 2026
 00:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
 <adNOd_yaPL3nlXUr@google.com> <adPyeCq3rQrTurju@google.com>
In-Reply-To: <adPyeCq3rQrTurju@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Apr 2026 00:30:05 -0700
X-Gm-Features: AQROBzDz9wK_xG9H3SLuw4zONQiw2niYTo0NvkRbRh4gDa0AsV-LIDgWyZanxn4
Message-ID: <CAP-5=fVyn+pLUnbMQ_XukhObb=qQiMuvus2g4p4Us+sY06rz7g@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:50=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Apr 05, 2026 at 11:11:03PM -0700, Namhyung Kim wrote:
> > On Fri, Apr 03, 2026 at 08:43:00PM -0700, Ian Rogers wrote:
> > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > which is problematic if you want to rewrite the evsel such as with
> > > off-CPU processing - all uses of the evsel need fixing up. Previously
> > > I'd mailed this patch as an RFC with everything combined:
> > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.c=
om/
> > > and there was a request to break it up.
> > >
> > > I've started the series by adding documentation to struct
> > > perf_sample. Next I fixed missing perf_sample__init/exit largely from
> > > the recent perf inject callchain rewriting work. The 3rd patch adds
> > > the evsel to struct perf_sample and ensures it is correctly
> > > initialized. The next 22 patches avoid passing the evsel along with
> > > sample for different parts of the perf tool, along with some minor
> > > tweaks like constification and not determining the evsel if it is
> > > present in the sample.
> >
> > I'll test and process the first 3 patches first as I found an issue in
> > patch 6 and I guess applying patch 4 would break partial imports later.
>
> Applied the first 3 patches to perf-tools-next, thanks!

It looks like you tweaked the documentation of struct perf_sample.
There is a typo s/PEF_SAMPLE_IDENTIFIER/PERF_SAMPLE_IDENTIFIER/.

Thanks,
Ian

> Best regards,
> Namhyung
>
