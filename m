Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211020CCDC
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778987547; cv=pass; b=hfp27geYnj17zQe9thbPEVlW63rctpejGd8PU8gIXagqfJKgiPaPvwfEyted47YvDN2WXuHYh5Dp013mGcBABdLb66RyqSO20B6nVVXI8LMoDdyG5tux1CvO6UCi6kzXY4FoEsTKE7ksM2qFVlvTMaW/0rO5qE3BgyLW/4NM57Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778987547; c=relaxed/simple;
	bh=0LU0rlTszNX5rMbUpA0bYFuoc8ktFNaC0iCLPA9g8/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FljBKeQLoQTHHZrc+Yyk78+ZWaLGGB+aqFpNIax5KX3HcWZjsG/t5XqARITYZ+I2xxmVh4R2wChQc09svPiOjna7kGtl6ljw0zy5Vlsl2Nyzj0pBVxIuQqORo+hgAWq7FPfJ+w+Ch8dudVLUSc0O404QlmZCH16auJ/xeABPyiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8GDrjlO; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8GDrjlO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso185ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 16 May 2026 20:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778987545; cv=none;
        d=google.com; s=arc-20240605;
        b=M22bI7vRIfXcwKiRD5FSoltqqn4/dCkNSuIpPwtayEsOKqoG3SKYNom6ifjAFxx5h0
         9G9xVrV2a4cUt9NeHtOq2Q38rOQwu2INOCgvkdF3iKuelM8uzGobBYpPpeYESkrjPb7X
         MWj/RbZ0d6dN3pcEJLK2E8qKlND+azw/EshKE6/KnWcN8O7HDAK5K5abSukvnYidxR5n
         rIbTcFvwLcZGalwgeA8H9HjtNmP/HiwfpAJyMDS5WVqXGPGvEgekT3fCDpVi7ZuD/mzd
         GooBJmCKamaxFJnwusTLIrjLWzkbWjAcXgZhXdHQT7kLOVhGUT7uKqEq2tRaRGcz8zwW
         8Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ncs0WXr2MZuyuWLCPAed6EASpM09B63JCNY7N1Fxk1k=;
        fh=gmowaEwM0H+mrQV8LyonsWBrcxPOeziFUAP+noJlrjA=;
        b=KPlfb2GvTfxA84I3xI0ASvmSRERoMJO/d4ThS8ZHHhLd4sou4LFqr+CZ/0myXzTsQj
         03K/Td+CDAnV5Za0aYqdg2OH2e7aM8uP0wLDiTJ5JnwWH94hFS3rCfvGEF5JXJ1ftyax
         g6bpYP955B7m9rFLgAX+IltJswdQxtp1DKbDbnmjAN21PJNLY6N5wWmy7xpL/FElShRe
         nhpcH+xEJ9EpyCCx5eAzaEfn4KpLn3qu6tdX2I7cwPyaYcEUe3hN/WxvWNvSadLK7bcW
         9fr9GgtOz1z5CngIseqRfjkqsQ7lz+6di7Zol39tt9+mnBoK0YxRen2tI3/zMSOAZFOv
         jMUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778987545; x=1779592345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncs0WXr2MZuyuWLCPAed6EASpM09B63JCNY7N1Fxk1k=;
        b=K8GDrjlOelEXlt2UFBPMirKIAwdh2mzbP+MVYUjkbmOb2buuSRsRxn3krVH5sbTf6d
         SCEfBU/vYxETzg68di3pUY0JZVAAe+hdqpIUZDHmlJ8tpV1j1F+qo1rulu9NaB60W8yE
         0WZSrjmJR7qeNkZaLuC4Md0hYBH+e1WxkGwjo6AeEMoNfsbH3Elwatqx4WJ7lS54R9i5
         d++X+PjTVh/aboBP6LAak6NGr7jCLnixMjaUqghnHETn49sT/c6c0t0EHhi7ZuAd1dR8
         Q6s+RNm2/9ZvXLcjNEMkRwo+XvZJx2PkpL3rYep6mc2QUjlHlPhiMPMG2xQnXxDM/IM5
         bXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778987545; x=1779592345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ncs0WXr2MZuyuWLCPAed6EASpM09B63JCNY7N1Fxk1k=;
        b=SYeWnlCDoZCVv/cwGP32ebscj5S8wyV1thFB1t0zcJ+eWVAzlMTkkS44TLCy2aM1wv
         nrjBli+xJauraC29diYILjzYmPhAIW4N1+qLfuTU7IdjdKfDRB1h3N+n/x08yJHKGubp
         m2hy8lN2wJTwhPbYksjGnugVZ4itn/hS4niCYSebs5T5zt33ywY1k0V0F8mDCWlgjuPs
         /FLOhOu+EHSBfBsXmO+bMJafPRnKu5aykBTsUdplZGkewxy9nPg3IpduLPdYaUh9tsPV
         bXyJ7QATKuvjdKQbOCOtCpbsJYCfsezn7hdfeq2Hyz87/eO2ulR2R0nTK9nb5eF25U5t
         HnSQ==
X-Gm-Message-State: AOJu0Yxwuca5DMdEWPihqvYipEBJgW1MNUQ/afZu/JNHI3qmmWy2H4mF
	P6DQqCSYtHBvbOq6zginK/LOFEt0Mj5dm//1ECr3MG8V+cXmJoOjsqK3p47B7bN0lhRk+bwdoHo
	Gife5RaRzXXpJdsaaKTN/KSQ7Aelol97gSc0ii+yY
X-Gm-Gg: Acq92OHpivMKsvtzeVNw9qx9L29ZAFw6BlxVnV/mnYDrnUHFdJ35Khav9CPwUs2xtwV
	3d7KHxClfUTZrCZxut/FHcU681v6v1wkB1veBdYNwE14vuQyKCYXosDMdUzLWgh9JgOFer8hAja
	JB0GpnJROPQR7e/Gzel1yUy+pwMS/fWUP6DsU8AYuxANQC1Mcl1Q3IfwxCimK/KEf6HmR7oghYJ
	U143perLZ9BAitCAxOr2t935PBtyeQe83pi0UFmd9psETR5KrLYGBsjFXAgeVCm+ZIibLQFR1Id
	dqR396KpQ596a+gjzOs=
X-Received: by 2002:a17:902:f64e:b0:2bd:5fc9:27b9 with SMTP id
 d9443c01a7336-2bdb303b124mr783115ad.3.1778987544535; Sat, 16 May 2026
 20:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW5Wozj=F2dnXoLTWmUjudNWLyjjg95CuP3Jk9bLcYwww@mail.gmail.com>
 <agfDsTgSyTRNIwgA@x1>
In-Reply-To: <agfDsTgSyTRNIwgA@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 16 May 2026 20:12:12 -0700
X-Gm-Features: AVHnY4JWCX8irtrndRl_Vbt_CeWkQOsgEilGjal8SBotpe9YWEEicQQmsr8eXCs
Message-ID: <CAP-5=fV9pORzwJLak8PhhozZ90=FOVvQMrR2CqpMniNNaQ1vsw@mail.gmail.com>
Subject: Re: Perf review prompts
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 6:09=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, May 15, 2026 at 04:52:43PM -0700, Ian Rogers wrote:
> > I think we can improve the review prompts for Sashiko and others, so I
> > sent out this PR:
> > https://github.com/masoncl/review-prompts/pull/62
> > I wanted to advertise this and suggest that others contribute similarly=
.
>
> Thanks for working on this, from a quick look it seems sane, some
> comments:
>
> -----
> The "File Descriptor and Directory Stream Management" is describing
> the dir equivalent of open and close and saying they need to be
> paired. Assume this is base knowledge for an AI code review tool.
> -----
>
> That is completely reasonable expectation, I would be surprised if it
> wouldn't catch this, but have you tested it?

So I was able to use a sub-agent to review the changes, here is the
output from antigravity:

### Verification & Testing Plan

 To verify that the baseline prompts correctly catch unclosed
directory streams without the verbose advice
 in  perf.md , we constructed a synthetic patch demonstrating a
directory stream ( DIR * ) leak on an
 early error return path.

 #### 1. Test Diff ( test_dir_leak.patch )

   diff --git a/tools/perf/util/synthetic_dir_test.c
b/tools/perf/util/synthetic_dir_test.c
   new file mode 100644
   index 0000000..1234567
   --- /dev/null
   +++ b/tools/perf/util/synthetic_dir_test.c
   @@ -0,0 +1,25 @@
   +#include <dirent.h>
   +#include <fcntl.h>
   +#include <unistd.h>
   +#include <stdio.h>
   +
   +int process_proc_fd_info(int pid_fd)
   +{
   +    DIR *dir;
   +    struct dirent *ent;
   +
   +    dir =3D fdopendir(pid_fd);
   +    if (!dir)
   +        return -1;
   +
   +    while ((ent =3D readdir(dir)) !=3D NULL) {
   +        if (ent->d_name[0] =3D=3D '.')
   +            continue;
   +        if (do_something_with_entry(ent) < 0)
   +            return -1; /* BUG: Missing closedir(dir) */
   +    }
   +
   +    closedir(dir);
   +    return 0;
   +}

 #### 2. AI Review Execution & Empirical Results

 We ran a full review session against this patch using the standard
review-core.md  protocol (which loads
 technical-patterns.md  and the streamlined  subsystem/perf.md ).

 The AI reviewer successfully caught the unclosed stream on the error
branch and generated the following
 exact inline review output ( review-inline.txt ):

   > diff --git a/tools/perf/util/synthetic_dir_test.c
b/tools/perf/util/synthetic_dir_test.c
   > new file mode 100644
   > index 0000000..1234567
   > --- /dev/null
   > +++ b/tools/perf/util/synthetic_dir_test.c
   > @@ -0,0 +1,25 @@
   ...
   > +    while ((ent =3D readdir(dir)) !=3D NULL) {
   > +        if (ent->d_name[0] =3D=3D '.')
   > +            continue;
   > +        if (do_something_with_entry(ent) < 0)
   > +            return -1;

   If do_something_with_entry() returns an error, does this code leak the
   directory stream 'dir'?

   Should this call closedir(dir) before returning -1?

 #### 3. Conclusion

 The test proves that the AI reviewer's baseline C knowledge, combined
with the general resource lifecycle
 rules in  technical-patterns.md  ( alloc=E2=86=92init=E2=86=92use=E2=86=92=
cleanup=E2=86=92free ) and
the remaining Quick Checks in
 subsystem/perf.md , is fully sufficient to catch missing directory
stream cleanups. The removed section
 was indeed redundant.

> For the validation of perf.data headers I plan to contribute what I
> learned while working on:
>
>   [PATCH 00/28] perf: Harden perf.data parsing against crafted/corrupted =
files
>   https://lore.kernel.org/all/20260510033424.255812-1-acme@kernel.org>
>
> That I hope soon to satisfy the last review comments from sashiko
> addressed.
>
> Anyway, I think this can be added FWIW:
>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Ian

> - Arnaldo
