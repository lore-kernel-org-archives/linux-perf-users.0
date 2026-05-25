Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4681F4631
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748799; cv=pass; b=bjlYFlf44zp3NwFo/E0C9BhXnmNuecuKkDreX+kTNrzO+Y1PKHnitpfqlWOmKeKB4RAey9pDrLEnyzaV3suMogoBowMEJQWswaBeCBtxu8DT+yeNTClbKBoef192sHu9M/lnmJP8J9NpozIgqLAMy/9e7Ng0cfwevZOxdKl0txY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748799; c=relaxed/simple;
	bh=LS+BqwgILP2THxGGAqu8xeG6HBWjlNewPPWnyrsGuOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDS4EBdyd7sxrJP5/+5F6VehXF/SvJCilTCPQ7Y1ov7fM7MAGqZbep2Mg+Ef0wSgHSnAk2utDfes4zsfXjjiGteWGICL6HFAB/E0cYjY+L2Vl1bCUAqT9OkMSce2qlj7Y3K+fpcz1NzM7Fwls8PjiagH4GyRO2lZNS6Ty9vnFd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZD+BKIL; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZD+BKIL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 15:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779748797; cv=none;
        d=google.com; s=arc-20240605;
        b=VQfa0rAs2MA/yQ2qfiS399kd5BaXcY6O5p0aiwoKThzagKJ/tfJW5n+CEriipLkYQZ
         titevYqu5XXrMCEhqTeXU6CHncOi6LVaquTqICKBkVh8CPzePgc7ZqQH4hHIQWTKX8NN
         NE/LypJblkwRqtjyLxj/JRsRFb8wllUWqoSKDnAc5Ns1pjWiRy+A+E7QRlaiOymOKY7G
         tV/ROH8kJdUTr+ha3Aq7FCbN0WfsocpxeM+D9gzZ9MHl6gbZJ5EOVrc/Gkp/31dlV1dk
         ovNAjLyAqPJxsOwuDZZcUVUS8nmioDBS6zD5EFrzz76zWdNJ5bjSO/lWDfcCjJ6jxg0u
         QmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YtRRktUFX7dimAvFD0k1txS2luZAEgC8WWdwifbSzBc=;
        fh=Ky8Z0j+OaLWuIgrAkpKzExmZWETxcmRY/jg4zy1ocmM=;
        b=d1k/HjjZCf/bvoQjqxMcKx0Ce2ubdit9tLLpLetzEMYXoxBM34uNRqU/bdE9tTaz1o
         aygLJbXNXzw+Qx13tzAKJbZKNzDV35+UqH72Xz16/01ZttGKOGfhqMHlR7CmKtqcCLsY
         L2tQUGvKUr1lxOwIkg5GIS3enw5QWXXSvr0Bj58PGtOSVL82JhJAfus+RZ73wmmA82Fa
         oAWFvJhjGhuoGuEHjzv4pyD55AO+hqoL3V/F64IalQpZGAXiGjsVdcl+Wh6G1Zkx2O6W
         Il3DQB/43JvWKl2WSAEBSqMdKETg8U+NXro3uHPRdVSTrw9/hiXydYw5m1WM+fMMCTeb
         7uCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779748797; x=1780353597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtRRktUFX7dimAvFD0k1txS2luZAEgC8WWdwifbSzBc=;
        b=NZD+BKILL0LN2Rmf/PgQGkXEB1BKYD2auYHR6+coRL4HKG586Y/MyzLP4aXqwKtViB
         hAr6RQ1C6yE9HA7QhpHFirDNgVZjMVNjvOxxwJbyz8ePGJ8zDi3tPJQrFGvGYWJC1xKJ
         fyDdovK48Z+g+pvsAXCWe2v5trtphbVATZUEZblfKJY8v32CMDX56uuUS/AZwscq7zyg
         SyndUNpodVi87mse2d9Q2uEmJxmtFPxUL5QWSgDBlETcJUjjZB81wzbJxyQwlCf7y9PJ
         CmMUk62DUmjL+EQHFX7QcNDZo3TqviRRs5ExTE3zsAN6b48yy3GZlZDgr6j1pGfXTYhQ
         YJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779748797; x=1780353597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtRRktUFX7dimAvFD0k1txS2luZAEgC8WWdwifbSzBc=;
        b=BjqLMlMslLU92n/r3PN7mJNHEgo5KdpX7B3WPxOGFIYF1Q3vo/W8ZTGhcRrgpLwUg+
         Y65SkWjIPRWq1WbRHGzieAQh91Q/0UIyVE7rcFjAt+1axtMCB9JoxRGBbrcPkKzi1bBj
         pWSDLBI9KylYlXAooM2ej1Cn+3ow9Vo9fWnSwYqBSM18swlsQX0QHbExgGKSiqt4dpVM
         oZmfVyf17g3H8r0/419EHX/5aSiCHQfDu0nKxzcHndUNnyozrjUibHYlw9cOVJD/qrwz
         laZNvNR13xJvCY9DElbteEc7Y6eFsC+/PRvXlCY59WBI6aYQym2yDZFlGfHFxN77Y7IW
         QdEw==
X-Forwarded-Encrypted: i=1; AFNElJ85M0XrpFHchf0Gz3v8vXOj0rPYGulas4ORG+zKGUutWGUhgMhYYrVLWNRYAdkTQjkiygn6PWyJ22Cjwl74xj6v@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvTRwB8+zWzC+pFaiz5/Gk18YrbXDsiOhxcjDqGw7uqARvvRW
	wZzQqnvaGGbsS6Z2XjN9fKt6cSNKykytlfKceDH754EsLxgzjxehek3lz9YrnuKviYyC7Fm4V/p
	MloZ4mpGh6z8UV/hwqxNYrbB4SvGMIjtd9lKLyikI
X-Gm-Gg: Acq92OG1Z40nh/ya74O9Wzoex6pUYizv8Lp93IlqaedZlTjkuxbm60R+0UnqnMKMntB
	O9T8iEINhWJNEPFH2s7DFCvn/mFBjY8ZuphoQWLJYJCRhr6nlrTLmNNZ1hQwCXC+DscbCbS020B
	TIVnKpCoBz9c4iRFcnA3xBbeH09Bq9XrM0KT3e81w4EZaUvuPuYWNKRtIVvjHlRi436yaY1yNQ9
	bn9LXTiBIIwOSa3SqmfXZPdVpNNoo4+HSlds3FwBVNjZKK6gYDd5mrRDe4zsJLIhWK/Rvea26vI
	+ehdAkD567iD/sl0I8c=
X-Received: by 2002:a17:903:1252:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2bebea02de3mr4131735ad.10.1779748796656; Mon, 25 May 2026
 15:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
 <ahStntuCibNk-IjO@x1> <ahSuZCJCQa4tE5aN@x1>
In-Reply-To: <ahSuZCJCQa4tE5aN@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 15:39:43 -0700
X-Gm-Features: AVHnY4KMYWv3qNKUqVnKwxsYEQRrbkKCgRv5srQjp63008XVUmADVFyVVV4IT_U
Message-ID: <CAP-5=fUF2DuHQL0A+QbcLqZwZQNmBEJXBAmD6YVYiQzE+1jDCw@mail.gmail.com>
Subject: Re: [PATCH v9 00/23] perf python: Modernize and extend Python API
 (Phase 1)
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 1:17=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 05:14:25PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, May 22, 2026 at 03:04:11PM -0700, Ian Rogers wrote:
> > > This series takes a different approach with some initial implementati=
on posted
> > > as an RFC last October:
> > > https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irog=
ers@google.com/
> > > with the motivation coming up on the mailing list earlier:
> > > https://lore.kernel.org/lkml/CAP-5=3DfWDqE8SYfOLZkg_0=3D4Ayx6E7O+h7uU=
p4NDeCFkiN4b7-w@mail.gmail.com/
>
> > > The ultimate goal is to remove the embedded libpython and libperl sup=
port from
> > > perf entirely, expanding the existing perf Python module to provide f=
ull access
> > > to perf data files and events, allowing scripts to be run as standalo=
ne Python
> > > applications.
>
> > I tried applying it now and got this:
>
> > Cover: ./v9_20260522_irogers_perf_python_modernize_and_extend_python_ap=
i_phase_1.cover
> >  Link: https://lore.kernel.org/r/20260522220435.2378363-1-irogers@googl=
e.com
> >  Base: not specified
> >        git am ./v9_20260522_irogers_perf_python_modernize_and_extend_py=
thon_api_phase_1.mbx
> > =E2=AC=A2 [acme@toolbx perf-tools-next2]$        git am ./v9_20260522_i=
rogers_perf_python_modernize_and_extend_python_api_phase_1.mbx
> > Applying: perf arch arm: Sort includes and add missed explicit dependen=
cies
> > Applying: perf arch x86: Sort includes and add missed explicit dependen=
cies
> > Applying: perf tests: Sort includes and add missed explicit dependencie=
s
> > Applying: perf script: Sort includes and add missed explicit dependenci=
es
> > Applying: perf util: Sort includes and add missed explicit dependencies
> > error: patch failed: tools/perf/util/evsel.c:11
> > error: tools/perf/util/evsel.c: patch does not apply
> > Patch failed at 0005 perf util: Sort includes and add missed explicit d=
ependencies
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > hint: When you have resolved this problem, run "git am --continue".
> > hint: If you prefer to skip this patch, run "git am --skip" instead.
> > hint: To restore the original branch and stop patching, run "git am --a=
bort".
> > hint: Disable this message with "git config set advice.mergeConflict fa=
lse"
> > =E2=AC=A2 [acme@toolbx perf-tools-next2]$ git am --abort
> > =E2=AC=A2 [acme@toolbx perf-tools-next2]$ git diff
> > =E2=AC=A2 [acme@toolbx perf-tools-next2]$
>
> > I agree with the intent and plan on reviewing and testing it.
>
> What I have now is at tmp.perf-tools-next if you wish to rebase from
> there,

Thanks Arnaldo, I'll do that.

Ian

> Regards,
>
> - Arnaldo
