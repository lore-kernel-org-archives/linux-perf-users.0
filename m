Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC43C6BA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762909; cv=none; b=iHpVNolzugDjbzZ1ldi+aM3fkiC9VupHmPSCJsLyCJH8mjTDUnhZAXM018/eSYWFv4jVWGVkNRVOlqixq6gWrNmVJBj52hZjlS5dTfdCOLgXKVkkI7CVjQRQqVwc/UnF0Fthyruzigou3yEIyS6RFdxdby+2jMVBZw7+H/ukg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762909; c=relaxed/simple;
	bh=dDP/NcYHYVzwgB6/qwfzH0/kwTnP0CjIbHa19u5/gSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lY+5jcVfnHtRTRX+2VrsMxP4ekGVW8lC4QTv4SDvy9GgF62haGNpv1r+uL74yEJhz+Tm+7l6srD7LFWifdy3Gk1f6UHl7bDxKTRpp34qNEYQkHul6FXX9W9P3PKKT2dvhJ4lKSxtLIpJg7G/KCmUzQFEJ4xTQFTy+H2l4UbfFME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCZsCDBL; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCZsCDBL"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so52175ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730762907; x=1731367707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipfdo1mYYQpBcI/ihqsP7TQB8/rEiwuOzHyfqYH/3/Q=;
        b=eCZsCDBLOdZ2G5kWxzFtw1qE9LG68JWIYefdoimqDDJVRHxr1PjNff8r7Txsu4m5Tb
         lJPaDnj4DqQ3N88VdBzSO4mfW3acnN0FnQHTb7xi+svDW3CHA8sX1gLYwjRtVgxHAw2c
         3ILjvtFefmkzYe5Z0j4YTSwRZVh3/0KWqZWvcsL6EtssyK01o/Wd6YOy+fkkeBnpRbyc
         dxKhnJ6ZLmebC8n+g9Ali4UIJI4IiWzr0LeAKGz41GYcYttcsGiUATz7hNClDngNkhZI
         ZVnm5w1tK3FV5WIvin3xK4YBERC+JjoSa5FCH7ljXB2p2mTtTI1Hbfm8+9Hrh88R+QnF
         gBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730762907; x=1731367707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipfdo1mYYQpBcI/ihqsP7TQB8/rEiwuOzHyfqYH/3/Q=;
        b=AdJMAU38D33VC2aSQo6EVfUPTtkbWKBV539gusPjU2LJz9xiwd9aUxS5tYurh2CWY6
         YxvzaSy+s5J/RJtT2rrpVj262fXKLpMfpwsmOUsQHX5sROKdTRx/Fo1LTsIR8wIMSTTN
         NmPGAll5PORF88OCe9BDt2nDHMIi8WJnugyBBVyFKMEihNZqU7cCjCGSCoBODZi7goWo
         LcxCn8rIHvZaPojY2cL5W11EsbUK/pmTdeYMqxzs9UhYWdbsekDo9+rezXbfRKrgvBeW
         IWW6mkoNIyamj2WVAkcZF66EFU2R2AFl9cVGEiQ8w2/83k0x9d6AnPpnWtym8D9IAsX1
         IR8A==
X-Forwarded-Encrypted: i=1; AJvYcCXrhDNulfhJy8Cl9YURyliI95/4cv16wfMmjGxJL4pQQp4mJxAx1IqUmfBBzguFdCsjngjm6jOn30QDAD1gX+ze@vger.kernel.org
X-Gm-Message-State: AOJu0YzssRoSsNqLqUkz7oZ9ct44xEfow13eh0Ki8ysrIranGyLUr4w+
	CqUf8/VPvc9yktrKFOqtOcD/sDZ7FpCoRlsmQmtNgQncH8Yw5FWU2TV/5+4sjSLTUGwD+yA/i5b
	spadCx+EfKUWNVTZDdUj1FYhwxkg46syDuMeg
X-Gm-Gg: ASbGncsW/XHxEEkxn17aM04GOu51tPakXhSeW1Lu89HR0RD4SqikqRAgB/CiTPA9wv2
	k8PadpxXYzxTeGInhO0ZOeJBmjFK+dOTuPq0hm2Ul64Ivr919yXA7/3K5O1n4rg==
X-Google-Smtp-Source: AGHT+IFb8IkolnKD36l6Cd9fk/Fqpq5akK4SZSiXKY4jygU0PdHfHbgLRskpxQpAz6+lShB2PuYvpjh5XEwdbUeRt0M=
X-Received: by 2002:a05:6e02:219a:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3a6dba4cb86mr427145ab.11.1730762907070; Mon, 04 Nov 2024
 15:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1> <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com> <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
 <ZylGJF7Ux3JdJllo@google.com> <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>
 <ZylXI4zj7Hs8Uvov@google.com>
In-Reply-To: <ZylXI4zj7Hs8Uvov@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 15:28:15 -0800
Message-ID: <CAP-5=fVK96t3-TKwqRQ1bfH2sOJHLhtVvDdJQ9U539Z1rd3kfg@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 3:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 04, 2024 at 02:20:30PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 2:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> > > > On Mon, Nov 4, 2024 at 1:00=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > > > > Namhyung was asking that the c&p of code be 1 patch then "add n=
ew
> > > > > > changes like using openat() on top". That is:
> > > > > >
> > > > > > patch 1: add is_directory_at - introduce the 2 line helper func=
tion
> > > > > > patch 2: move the code
> > > > > > patch 3: update the code to use is_directory_at
> > > > > >
> > > > > > patch 2 is known broken as patch 3 is fixing it.
> > > > > >
> > > > > > Hopefully this is clear.
> > > > >
> > > > > Actually I don't care about the patch ordering.  My request is no=
t
> > > > > to break build and just to separate different changes out. :)
> > > >
> > > > So, patch 2 can't be separated from patch 3 - are we agreed? So we
> > > > squash patch 2 with patch 3. Patch 1 is trivial and fails to meet t=
he
> > > > bar of a meaningful change, so we squash that. We end up with this
> > > > patch. If there's a later revert and a dependence of the 2 liner, j=
ust
> > > > don't revert that part of the change. We've never had such a revert=
 so
> > > > it is hard to see why we need to generate so much churn because of =
it.
> > >
> > > As I said the patch 1 should be the c&p and no need to introduce
> > > is_directory_at() before that.  Why not doing
> > >
> > >  patch1: move the code
> > >  patch2: add and use is_directory_at() + openat()
> > >
> > > ?
> >
> > Because placing all the code in 1 file expands GCC's analysis and the
> > build fails. In the commit message I describe this:
> > "The arrays are warned about potential buffer overflows by GCC now
> > that all the code exists in a single C file."
> > A standard unsound workaround to this is to change "sizeof(...)" to
> > "sizeof(...) - 1", as it is ugly I added is_directory_at to not suffer
> > the problem as the arrays are gone.
>
> Ok, it's strange that this type of analysis depends on the placement.
> Anyway it seems there's a problem in the code already.  Then we can fix
> it first and then move.  How about this?
>
>  patch1: add and use is_directory_at() + openat()
>  patch2: move the code

I'm happy if the maintainers do that.

Thanks,
Ian
