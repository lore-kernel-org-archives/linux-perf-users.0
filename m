Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492ED244685
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020529; cv=pass; b=rsLI1Qyqb0bA8fHI2dtS1VRYCs1UB1IrUrbHSBC9XqWx69KkVebhzIc0gsn0ewjDCDB1xOO6RJoa9XkwebVCthKZKkRANYDRJuGEhbW9qhx0d0VS2u1+f/cEN2FseLXKcAlwv2x1Js/CFF8E+yJTiljl+9vxDLyyFZXnygbr6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020529; c=relaxed/simple;
	bh=1MvntXOJf0sS7Uf6bUp6VJq6rGalNdy4z+213yKPIsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLgbrkNyLIiMQnt0K+QeYzEmhxjV/j3w/nxyHKJvmjveH4D4vwl8tXRY4nFfvMz7vEd0j/y9h+sZOEhON8VDPdVSG+o5yZAMI8HRAoYQHYoug5dbjxgHUSkPVKCrdNfoTQ6NGusGmKAayjgq9eQTJvzwrv7D9GPKGyHb3X9OYOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=af3bbXTQ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="af3bbXTQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2591757fbso196045ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775020528; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd8PEPcgnu+95e88aHVRzR9P+bQdwSP3y6ST3PNFPjOMP6wzrR70MavvnSCarjTzvn
         INnMieI0h28qx/orGNSoEB/tvuQQmTMVC8OH1X0GjheJO6XcXI46a/3IETRwlNx0y11m
         ju+74l6GTqbLN0yWiDbCfPvc57tEEK/jIsRnu+3LjCc/Rl1johgqen73zRw7iT79SfKb
         4j4T5XggrJPJ2Y6EdTs9vlC8wFxf6l6YLDIJI1KlDFbSZA6d/KWXvGZkzNVSo21prMFz
         j2wg3Fj+PyPsH+Pc1P3YeiRr2DWl+v7xPZe8RoIMc92/wox0c3xtV7qOdD4fYZXIDtir
         rVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MvntXOJf0sS7Uf6bUp6VJq6rGalNdy4z+213yKPIsU=;
        fh=04T4yVTsQinKw7FymaEzyjnUaB8NsABDeLxA/LjIHKU=;
        b=aCeZb+hhsHv3ajEDTNp6dNQATsfgW9AD0ryka44pLgIGcXRlRBMC2J5qKI88do/JWc
         phqTmQ9oKI/8VsNoHPIwPDGq/Rw7RYT1UGKiDH34W++geOdt0lwTfRV7fORM760CeZ7z
         AqTGW6qZ0rx7hc1IZUEOF7n3BYJ01T+4vUUH1TBZdzXOk8AD2CiIgyJcDtxgoDhS59Sl
         iKBbXfJ1j9btOscQE8WNpz6MxAwvPxuIUItSlP+yg/85u+dG7lozMHTL5vgnJCP0DEDX
         cxvbrHIG8kxGs+y8rdSmX1ZxAIxU2f75zxswUbnmCCWT+Ngqtwe2k6mJiOJBGKU23oJA
         KreA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775020528; x=1775625328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MvntXOJf0sS7Uf6bUp6VJq6rGalNdy4z+213yKPIsU=;
        b=af3bbXTQ0AtPa1VLLuj2NLBrM+9PeJ/Is93N8FuKH4YzdatTd1oWCxfDi1cjqgDC7d
         C9oyDQ7u5dnlHepTurdyYyTUO+j+xhYEy4RTfjbtzR6oTq/L29YNaVWrd76eqZL9Y5iD
         GxhTKeB9QKbLqwUmlR1u/VWlJENsXTayzVK+dSa+KugG+sh4eLO/duWygW8Y+c3nclP9
         jlUYsbZxC/pPIVNv+GAkIMttyGfgIQnJvG7tcw7DU7SCXVNps1ULjcAc5hI7UGLVXDpK
         dN9tN6EeZThW0vUDvaZjIc4jsnparIfrRXAp2/zGqX/AfR4UfBMS/6DZM9QJ02vU7lKg
         x13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020528; x=1775625328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MvntXOJf0sS7Uf6bUp6VJq6rGalNdy4z+213yKPIsU=;
        b=WT3YJDQb6/xry4KFKtrk/QDtOsBHLoUL19r4vbZvU4/pG1mtP6//i4j74FnK1HD4gF
         hiSe7ZKCUtW601utwyiCodUFE49OLuLetjWP5MCuGCsJtzJmOtuUzA5NlFj4PQT2y9cY
         b8IfFq68Yk+ao61vN31xdvdPY+RmCIdtulPiCoMa4OpVIXcg+l6VzIDf9LpP7x+WNoOZ
         LAFwTOkc+deAICP+vCgT1Gm2Tvtm6X1BXKoXTdaOBAF6wEQMLeBQd5afGuG1UDBjEkjp
         S9vkH+Q2ADjXIi5HA07gDt7VdEZMkaPL+b4oy3ypCg/IXUEvAqgqsEHE4yKnqvhXvXhN
         doYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/tYWfavU5OTaGDXYJDksutmeJ6c0TZa8TrUJr49+W6OzOMG2MfsOG569t7KAlDmZVDysJkf6nM+/sni9tgR4j@vger.kernel.org
X-Gm-Message-State: AOJu0Yww44yhV9E9SS0WXOGD+MB9k1G0eRjz8+5QNcBRdCQMYpGFRxSH
	TCvvX966qrxewNzf2RN7huTmHQToeAk5cpYOXU0rQOrwKKjByL2O7vozVW7y9vHHSO/k7qwbuDE
	eNkgTPmQfQXcvUMiohSCD88IhfELy4tzdt/EjhcEF
X-Gm-Gg: ATEYQzzmg32LkyzSonZwd/IytiunG0x9E2MKKeSg1T0nSaAMsl/7yNbcKuE8az5QwA0
	wh0TV3YvdeYEHMA6Pyx2+ON8Pcl5ZUuV3YzXJBnFXx3jWpi6RA++28a/id1dJCcTIekfn+Mvo4d
	qlQ+Y3PM4ecjpfF3mH8PrTiQq0yFWE/Cro7FgKUV8P4rkhNMCZKucr8M42Q4Qm4w6eFMh3pWAAu
	43CEKoN62I98g+zWo+3ZMm8aU0r43iEFKNUFy8qZMd9ECKjHxi/W/Qx21LotBUyhk675zR6nXQW
	4oCjYvOX
X-Received: by 2002:a17:902:ccca:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2b26b2b089amr1196995ad.12.1775020527147; Tue, 31 Mar 2026
 22:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204214235.589865-1-irogers@google.com> <aWGtNvi9kbBCTNVE@google.com>
 <aWa75MJy7FMyzR9P@x1>
In-Reply-To: <aWa75MJy7FMyzR9P@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:15:16 -0700
X-Gm-Features: AQROBzCmEJuZtlFqr0qhEBVO19ZbPJuTbsP2MrzwVnRUICGOrPO_pkoVq19TU88
Message-ID: <CAP-5=fUcceQuKSu_FhOPxpsXwi2ou+iR3VHafcy1kCHa0CeVhA@mail.gmail.com>
Subject: Re: [PATCH v1] perf: Make more global variables static
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 1:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jan 09, 2026 at 05:36:54PM -0800, Namhyung Kim wrote:
> > On Thu, Dec 04, 2025 at 01:42:35PM -0800, Ian Rogers wrote:
> > > `make check` will run sparse on the perf code base. A frequent warnin=
g
> > > is "warning: symbol '...' was not declared. Should it be static?" Go
> > > through and make global definitions without declarations static. In
> > > some cases it is deliberate due to dlsym accessing the symbol, this
> > > change doesn't clean up the missing declarations for perf test
> > > suites. Sometimes things can opportunistically be made const. Making
> > > somethings static exposed unused functions warnings, so restructuring
> > > of ifdefs was necessary for that. These changes reduce the size of th=
e
> > > perf binary by 3,264 bytes.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks, applied to perf-tools-next,

Hi Arnaldo, it looks like this patch got lost. I'm not seeing it in
perf-tools-next. I suspect it needs a hefty rebase now. Any idea what
happened?

Thanks,
Ian

> - Arnaldo
