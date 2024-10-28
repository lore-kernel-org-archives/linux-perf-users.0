Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB41DFDB3
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142645; cv=none; b=rysJ8vyw+vklZSXJyYBNM972y8uv54HPgqxcwTVVofA4goAZ1YN3uCJyOEgaHgmnZZ6N1pBFXEEgSFI4E9ax0krFN+lE/1efcNxmSkjSlr4NZPsHpJnqp8bQfY6xqeu9Vg+PnNZMsmvyv7IhjiEt/MkfAmwkOlK6IuO1AaZKmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142645; c=relaxed/simple;
	bh=32AuFszMUKT5DLdd5nIiGjbeuBc7WYxahugru1WcfCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRjfJ34bfqATfgyoUq8bHveOaOPVt6Hr4I0iG1wfgSqkT7IRrwZPwMRJgIaMeuqwmRwuR1zpfkmxBkP/H+7uYf7LrGh/4SUC8d62pfyHNstoM3YxTw7UhhcvecgDgng5z3yfGQksxxAaiqHN0/Q1bF5JBcu6nz2WikjKFYnoDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbuuT2XM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbuuT2XM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b295b9eeso42121cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730142642; x=1730747442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32AuFszMUKT5DLdd5nIiGjbeuBc7WYxahugru1WcfCE=;
        b=vbuuT2XM1qIAUY3IH8VXuhTbk4Uv50CT2bDIAYPaSquOVdcCFPqzkZ+PjMmlcb+Tu3
         58cKEfvP7o9BdfzyA8DaAj+pVswO/6eQD8opdZTK4vnkT/CMsIopfBaTkO6/2z+ktUVI
         pQLrrKYvU5D+o7oz29XjCiUUtdK0V/VgP6DirPeGPDU5zez8THWW1ZxVykgKJcr6kSox
         EZWGeaksylSdbRYMip/xgNKfroceDvWRwaRUp2ww/5ZFHz1VcLjR6SVhl+xVSQGeXYrj
         Rt8GSzAvuwnxeraDBUfopHPN+WP8rWSYyzbB1vjxk5jHTcqxdkP+W1ChK6TN7AUoJj1B
         QOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142642; x=1730747442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32AuFszMUKT5DLdd5nIiGjbeuBc7WYxahugru1WcfCE=;
        b=ouS49VPdH9bRsg90WNpVKaHgGOIqOuK2Zjd2yyDxl74xIApiKnmvEU2XIO7YfgZS+T
         4Z6dSBcVA0+RBSHJwry0sljE+OKDUO7qKuap6EIz7ItcKxJATGk5Qwrjy3G2alfFYk3E
         dssFejs82Rxjg7BDW5jBxDbRi8ZGX6DWs0gAVNASmKRoxG8EH2+zRM/QFRIu+2NXyHo2
         XKVexoImESeKehLylmeI0s0KK9007I1mcgly5TqrvRL9MfMff9sZ50S4DZA/vHULPyzW
         Z3y3E8t9LgxzIxKXUFklt3bAxKOnYCZ5AC4MWoKix8q4M5cxH2JRFoCqEzANubt3aMLR
         X82w==
X-Forwarded-Encrypted: i=1; AJvYcCXzImvIxpLSMmOvxlymtwIys8PP3QSz+Fi6hUNarWEzX6G4qXjsoXyr9/njZjbYVz+mZbzT6Uhy7I3xsE3Pm4Yz@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGwmF0iFpjXloKf1LM9Hl2uAsGSI+EIaxzPcoe1eJ7yWLW/Vf
	bZ3BiHKlN0FX2ieuvJN/UsKqdcWF2bSmfsh858AC9U9XCrtK031MiXNmCXPmTrrAJxgT1GLz4YR
	dCvkLqz3gU992kBG+AeShsfz8BV0UfAt4gqal
X-Google-Smtp-Source: AGHT+IGItQXn4sKUPZhRmh8zcDmQcBJ15fP7uZ3IBzSB+dvEscffQLiuXwhmWZkM9YGGjDNVO6VdA8kYoctcipZDsnk=
X-Received: by 2002:a05:622a:5d3:b0:460:4aa1:78d6 with SMTP id
 d75a77b69052e-46164fcea00mr544451cf.20.1730142642275; Mon, 28 Oct 2024
 12:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
 <Zx-1tx0eH19iBpjy@x1> <Zx_DXt3ESi394mcx@localhost.localdomain>
In-Reply-To: <Zx_DXt3ESi394mcx@localhost.localdomain>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Oct 2024 12:10:30 -0700
Message-ID: <CAP-5=fUOv_bV5Xmr=hHjARgTMfa_PkFH6ZKBt4Yk3FK2KcORSA@mail.gmail.com>
Subject: Re: Can perf drop libunwind support
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 10:01=E2=80=AFAM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Le Mon, Oct 28, 2024 at 01:03:03PM -0300, Arnaldo Carvalho de Melo a =C3=
=A9crit :
> > On Wed, Oct 23, 2024 at 02:57:05PM -0700, Ian Rogers wrote:
> > > Hi,
> > >
> > > perf wants to build with BPF support these days. libbpf has a
> > > dependency on libelf, part of elfutils. libdw is also part of elfutil=
s
> > > and amongst other things provides unwinding support. My understanding
> > > is libdw unwinding is used by perf in preference to libunwind when
> > > present. My suspicion is that libunwind is being feature tested,
> > > linked against but then seldom or never used. Given this could perf
> > > drop libunwind support in order to simplify the code base?
> >
> > Probably Jiri remembers the reasons for us to have support for both,
> > IIRC libunwind was a bit more mature at the time and so we decided to
> > have both and when some broken behaviour appears we try the other one,
> > in the process trying to fix the one wioth a problem?
> >
> > Adding Frederic as well, this is when we started to use libunwind:
>
> Ouch, memories are blurry... It's possible that libdw deprecated
> libunwind at some point. I'm sorry I completely lost track of these
> things since then :-s

Thanks all.

Something that Arnaldo has mentioned is a need to reduce perf tool
dependencies. My thought is that CFI isn't that interesting to require
>1 way to provide support for it. In fact all these library
dependencies are something of a perf source base curse, where we look
to libraries or forking processes rather than doing things in the
tool. The tool pays performance and complexity penalties as a
consequence - see the removal of libcap as a dependency as an example,
also how we process addr2line output.

Masami and others have mentioned that potentially there are users for
libunwind but at the moment nobody has been able to come up with one.
Given this I think it is safe to move libunwind to being opt-in rather
than opt-out as in:
https://lore.kernel.org/lkml/20241026014305.233607-1-irogers@google.com/
I'm hoping by doing this we'll learn what the remaining libunwind
use-cases are and possibly to make it more of a default again. Of
course if it is just baggage then we should tidy that up.

Thanks,
Ian
