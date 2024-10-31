Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52971BD9DC;
	Thu, 31 Oct 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417311; cv=none; b=eZCcx9y0QMfc7gheGWy3TFODLRuOldrDXo2gQzlrWSPnA6YEnqfUURBQsK/9CekhD1zXQvwbCCEHHO1Rl7fiHzQgPfLzGarVLT8C9QMl81yhB4V8vFt4MIoj2LnTPMjbzfWQXxIfmYdVBiy0thucMO7D+a2fGB1Uf20f6oYtdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417311; c=relaxed/simple;
	bh=ihn1bJ13O+ICGeD46Kou/82Z2V4tl7Akt0tFFGiiYtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpz3P2xUDynmzE5bsXtGHRFfAXV73j1Nf1EvC+urbDjIehJFyG340zazHv+yU5EUvkN4+qbM3Pod8lz9UR10Ge1JeEnjGZ+yxrqMSUJnHtGN+lnFmeO59VnY3sIuzu/81SdeFcxd1MQ+Y/Or5JoHy9yDnzDhBsMgrNNBAS935+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbGb8gwV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbGb8gwV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a16b310f5so213266866b.0;
        Thu, 31 Oct 2024 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730417304; x=1731022104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hefIWSSLnXcBqftg5nsPi5v85nNJiSjiEC3JHtAntbU=;
        b=VbGb8gwV/IQsp1Lo1OwhLFzeSitoqjIwCDqBDyIQ7Ts+PntsZjITgTSSfJYSC4ySPV
         2IspDADeVcvLwytmapb/Xr81Qk6oTFnucPdJAVy4hFtmq/CO6O4VLvUBbnmtXOx1oUyU
         GfqKfeiNeHTyltWjUOnuUvdtd+wtKga2v1geQZeFXXZojguSotS4/jY+tcyIr47QzaOl
         TKhj/ziaC37fO/QdrvTHYcL5ufbWnjlFG99c8z3wbmHYzpCpbTwZSlo8TMuZ9dEuFrFe
         Q9aF4aMQKnZlV2wyKWEeNGDKHaoidU6fVqYOBPTj/Em3mmQJaavRq86MVLWHKdIEgz7N
         /uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730417304; x=1731022104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hefIWSSLnXcBqftg5nsPi5v85nNJiSjiEC3JHtAntbU=;
        b=gM1+iLHS1yxLgYwtBOtloG2UiCJci2NUeA9ocpTkqw3T0/OIK+KvmyesM4vSVGwk5a
         hT+dkSWTVWUFAS/WcFpzaLnUJ/WXPNOGkux+1rzwi4xqAci6b0gsjfcJOIVgAoNPah0s
         UbPpGhIWwp+QCcunW2d6bhzE8YPG2dEMxuU4Ss5hs59XZ0lpH7xyVvgMaCW/OhNkZfdX
         HgT3KnSyR4Zn1XrrsPJUNkMd/FHk6M6kg9cea1E5yKy6PtBbKx+e6Eg/jysjtcewLZY3
         RJ8Nvc5zU89oobBN7jJYtewuXuUZRjeE5n9oTP97NKx6aNgN5WHB+9Piqi59RMb0eJ1v
         F/9A==
X-Forwarded-Encrypted: i=1; AJvYcCUWRGb++4D79PJ6KXmlYOECXHIC/owXICFmAaDQWISyNXbxnwcjvURmJfaIOn/DLLmftYbZdZ+xQVJE5xOh2AFojA==@vger.kernel.org, AJvYcCVU0eTX2ks2wzeh4je0nUi6HTtUB05YVXbNZoNLnH5o9CCGCy9oBDSP46aGvZ0bLliCU35Q/GvLKVHpcDY=@vger.kernel.org, AJvYcCVWMat6zcVDsRrFBdgy9KY5Be+trJvICBFP0I0E3VMDFRZvNKOB8S1fliNM1gyW8zEBwa0HCrM7q48km0LfQvBugg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycO0WIDwUh+NcWXIQTyHgo/d38oTFLMPLrFxUDQFy4O/QIM3Nk
	3AYOLFNusOkYwdEfdFGZLQQjgCH3zrINWFf40P6iEfNdcqjrjwrV/23uaSvzJI8caViRqO/f3pd
	gZx9E8ELsaSbbuV/v5o93PH7mxuE=
X-Google-Smtp-Source: AGHT+IGTC95RMplTXIl7pdwB3Xefp6E7/dapQh+1QehK1yKeaffEy3sTOv2KING0JBmtpOOXvlQk7L+Z39psP0sM3qk=
X-Received: by 2002:a17:907:72cc:b0:a9a:3ca0:d55a with SMTP id
 a640c23a62f3a-a9e50cae005mr432051466b.57.1730417303621; Thu, 31 Oct 2024
 16:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
 <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net> <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>
 <20241031231320.h2hwns367e5byvyy@jpoimboe>
In-Reply-To: <20241031231320.h2hwns367e5byvyy@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 31 Oct 2024 16:28:08 -0700
Message-ID: <CAEf4BzZksT=GTs268KBiCsYxUcvWz5KUghjKQQR8OxGdoBt=6A@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:13=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 02:22:48PM -0700, Andrii Nakryiko wrote:
> > > Problem is, the unwinder doesn't know in advance which tasks will be
> > > unwound.
> > >
> > > Its first clue is unwind_user_register(), would it make sense for the
> > > caller to clarify whether all tasks need to be unwound or only a
> > > specific subset?
> > >
> > > Its second clue is unwind_user_deferred(), which is called for the ta=
sk
> > > itself.  But by then it's too late because it needs to access the
> > > per-task data from (potentially) irq context so it can't do a lazy
> > > allocation.
> > >
> > > I'm definitely open to ideas...
> >
> > The laziest thing would be to perform GFP_ATOMIC allocation, and if
> > that fails, oops, too bad, no stack trace for you (but, generally
> > speaking, no big deal). Advantages are clear, though, right? Single
> > pointer in task_struct, which most of the time will be NULL, so no
> > unnecessary overheads.
>
> GFP_ATOMIC is limited, I don't think we want the unwinder to trigger
> OOM.
>

So all task_structs on the system using 104 bytes more, *permanently*
and *unconditionally*, is not a concern, but lazy GFP_ATOMIC
allocation when you actually need it is?

> > It's the last point that's important to make usability so much
> > simpler, avoiding unnecessary custom timeouts and stuff like that.
> > Regardless whether stack trace capture is success or not, user is
> > guaranteed to get a "notification" about the outcome.
> >
> > Hope this helps.
> >
> > But basically, if I I called unwind_user_deferred(), I expect to get
> > some callback, guaranteed, with the result or failure. The only thing
> > that's not guaranteed (and which makes timeouts bad) is *when* this
> > will happen. Because stack trace capture can be arbitrarily delayed
> > and stuff. That's fine, but that also shows why timeout is tricky and
> > necessarily fragile.
>
> That sounds reasonable.  In the OOM error case I can just pass a small
> (stack allocated) one-entry trace with only regs->ip.
>

SGTM

> --
> Josh
>
