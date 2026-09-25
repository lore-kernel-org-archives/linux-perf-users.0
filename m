Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EEF36A01A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374841; cv=pass; b=W9x/xBSlgCsiNLdjEAChkexlzS1BaQ80DekWjC3ssmfZlTo+3XxiEKN9WZGweLfHFgtMLqzAuHvSvbBKpqgN2nSERILDsZsIZAFichVWwvVXKx5N/5lCSddARHF/tvxZWaQ4xAAp+FNeQBxhNBkl9lsnYDXVtfINFFK6Y3LYJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374841; c=relaxed/simple;
	bh=JowJxQD1sVZ3VW6m8jTHLGLHzOoAICdF2DxMxMqKMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzHIyXE+wwtADIj8OSFz0zPyYJ6xIO7n/Et/g2NtCsgpjMyU5s/ALTUkuIlTNfdY6XFWrPaoVbzkkzlnhgezmC/C1IsYMgAWo8MskHgoqzjCBzDZ5ULE9ghveJgtCLWszp50L4lTbROKbAwb7zDFPNxSynarOu1Ka5axliVEUa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7ml9l9I; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7ml9l9I"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so94881cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790374839; cv=none;
        d=google.com; s=arc-20260327;
        b=lcBI6w+yi2pMIp1I5AgkNKyHUrVtWALLg/4hCFHK5qMeJ5axfmd/XEsO/n9enB1gbj
         jio8cIqxvwtZPZONhbF4h1IH38isNOjW/S2DVHC/H0tv8HkMzSQqZZkokQEGjByU2+qC
         7aIzwP+Iur1naxKG0GzbTCB8OthoTuhym9cO90aU1oH43yEgUJCO/l4l2/ED6Y5KXgwX
         sj4p6VLMzxXBC0Nql9jGv5WH4puKX5ClrHswBHabTLL/V+fMIwoaMt/AfQtwhV71hitY
         WpmguBDlAKb81YAo/G16gZpdhYF2R+RYR/H13OFR2CcOtPAHGIi4Ec2eKeA8HAqZRcmX
         TKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JowJxQD1sVZ3VW6m8jTHLGLHzOoAICdF2DxMxMqKMQs=;
        fh=dikHI4bMMids05VjWRaVCKIKR8UFJ4nTfFxwDdW+Zvw=;
        b=IAtekUuH3rG5KmmMYHM6ls0oQC1OXLNNTElGsaQqCNk8VIltfxAR0c9q3dJUrD+v5t
         4+tqvQK/x/64rdkboYFkeuBUOOcTj+AmSefKCPq51u6u+gT+VrfogirzxXSzJLhs3N71
         ShWWVK+BMisv9clfjiYy2SmL2wAtEU/JdCXBOBhVgrWnvzyIslqLucdN9OdawjYHi1bL
         dCw29Fu69MSb5p719PNRhU40un/JBujH8Q5zKMs34aFjEtNsAMEFcAPGfu1gykmsw5wH
         oAu44EWc518njZqlBhO8N4h3IjOEqqG04X6RNQo61wuzU0+BlR6bpL1RHmLfRj2IxO8S
         qOiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790374839; x=1790979639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JowJxQD1sVZ3VW6m8jTHLGLHzOoAICdF2DxMxMqKMQs=;
        b=a7ml9l9Ij2OiChxutvnqlBNB+MY4afYXQQCACGx8pknIedoRT9iOjlrrMm2UYuOEjx
         7cfQ8glx22SgbxutljTl/a/kgDF6Ysullamz9wFkkhCkZ4YC63WGsiiejkmOoRTLjw68
         ChK/kuroDdDMxMBxr+iR02KJ634BPptkAGlIqt+BY6gQobFh9IkisO22+pD42ZZ/aSL4
         rnJ2umazE0+m8g03H1omuswq06j/WTG6jK+P14AFpxV59a+Ee1qpN8L6HbLfv3RUjU0L
         qBjT4ANrLY3ck9dab/YKLd3XnU3CjXKZVGXVpjb7QFatynWXv9zSnBnJUXQbo5nv4yDn
         A2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790374839; x=1790979639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JowJxQD1sVZ3VW6m8jTHLGLHzOoAICdF2DxMxMqKMQs=;
        b=w64tvrINzsrEwhdBMftCzPfxm+QTFjx8j86Dya04l1XnmZdDXgotcJjt3cei0BgOiR
         r7fXB1wxDKj/Rxcmpo091XA2Tyfv7KO/fC1yRyuNi5TH/cnbOo9+KSq2htyxvyzzY6Uh
         Hx2uGZhhC+aCiPcXDE2WLngobOKl2lLWpDq7lGcHdAcBULfj0XrzZQth0EPlX69gMf7h
         FG4FD7nABOQ0uHOMn34Z7m2tHtU+jjVXTWJbtp9s1/btiMHdiDRmOcPtH1evPOWZO6QT
         9oIRSqOyhj4zPCYe5cTBbKyrPT+Y2UhMhfrHdmXynRnJlDsOYShKoJ8/d+S2tP5VOP1t
         PT8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz+mFL39Yol1qP0OVmG83YodmZObZo2iSZ0/vNxzYCWtWGa/PSircKxEXfhEAraFl8+FVJinVMyxdnUJNl9tde/@vger.kernel.org
X-Gm-Message-State: AFuF++kQ+IA8vl7B7wc5ucZe3/St15gIUWDhJyc+yQ/7EAM6cO/s/XJe
	0GJ9VtOgB0vj+n8Hq2FRo2U0jPIJFgid6g37ezypjqYaZRwepm9Z3Y5JhSwZzQU0+ZRqWhSeRo+
	+gcexiRFSxHomy/7yis1EGTz2ORSGKSlnOkHQKS3q
X-Gm-Gg: AYBFou3L6C2A8BmqvL1Q50gbKQn4q+bj4c9yUOeAiDOoJXQKUYtKdP/gB3H0oHwS+39
	lpT9ce1WrS1JT7D+dr8AGSc/0gtcoBAW9nQWrudkqZJo8mLAZvcb6bJsFQyzHq276DBjFkOs2xn
	tFWex+ob1tjZIt9kTtdxsQSUwRs12B6DFg67c6UVAiRnpZVP12XFExOotc99HfrRs7CIsvoeuvt
	ORmcKJzqHgkAxi70xXwRHSOKrTUVEyIFKub/OjiArbA6uplllbf54Jd3ROKig5/nVPMcd+xRO7y
	craYjSdD7oipLN+aU5yMmMAuMDINJvXq2Fy/kwxasXwUPGZvu3CKDUJ/IfdjahUgBqKOpPEpyWD
	oR+nBaREWTQ==
X-Received: by 2002:a05:622a:4a8d:b0:530:ac23:ff40 with SMTP id
 d75a77b69052e-533226c3eb4mr1816751cf.5.1790374838279; Fri, 25 Sep 2026
 15:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arbd4TJm4s9MVjN-@x2> <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>
 <arbkQymeBZ0ja6sc@x2> <CAP-5=fW3yv2u4MS1TrbLe4iBL_MyfJx3m4KvP5visKsmT_qwvg@mail.gmail.com>
 <arbtJUe-jizeRugc@x2>
In-Reply-To: <arbtJUe-jizeRugc@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 15:20:26 -0700
X-Gm-Features: AclHuK8lh7YaY4Gazmy2PxZ_hCMkSClROlGFg0_LVNcq9y9re_7LtI5D7WE5q_8
Message-ID: <CAP-5=fUmBT1WokQXiDPRutYZKOYmSBFknhU3N3qU4-Zxy82yBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py and util/setup.py
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:52=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Sep 25, 2026 at 02:29:12PM -0700, Ian Rogers wrote:
> > On Fri, Sep 25, 2026 at 2:14=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Fri, Sep 25, 2026 at 01:57:06PM -0700, Ian Rogers wrote:
> > > > On Fri, Sep 25, 2026 at 1:47=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > perf's build still accepts Python 3.6: Makefile.config only rejec=
ts
> > > > > interpreters older than 3.6 and jevents.py keeps its own removesu=
ffix()
> > > > > shim for it, but two recently added constructs are evaluated when=
 the
> > > > > module or the function is defined and only work on newer interpre=
ters.
> > > >
> > > > Could we remove the shim and bump the minimum Python version to 3.9=
 to
> > > > be in line with the rest of the kernel build?
> > > > https://github.com/torvalds/linux/blob/master/Documentation/process=
/changes.rst
> > >
> > > Since RHEL8 based systems will still be in use for a long time and ne=
w
> > > perf versions can be useful in solving problems in such systems, mayb=
e
> > > we should keep the support on 3.6 as is now :-\
> > >
> > > This patch is not that big and fixes the only cases where python 3.6 =
was
> > > breaking, so maybe this is not unreasonable to do.
> >
> > Could we update the review prompts for this then? Currently the
> > prompts load from changes.rst:
> > https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/bu=
ild.md
> > and so Python 3.9. We can then comment that we're doing this for RHEL8 =
support.
>
> I didn't know about python 3.9 being the minimal version for kernel
> python usage.
>
> > RHEL8 appears to be in maintenance mode:
> > https://endoflife.date/rhel
> > which means "New functionality and new hardware enablement are not
> > planned for availability in the Maintenance Support Phase."
> > https://access.redhat.com/support/policy/updates/errata#Maintenance_Sup=
port_Phase
> > So is RHEL8 support only necessary for people building the code
> > themselves? In that case, they could also update their Python?
>
> Fair enough, I'm reworking the patch to instead make 3.9 be the minimal
> for perf as well.

Thanks! In the python series:
https://lore.kernel.org/linux-perf-users/cover.1789880842.git.irogers@googl=
e.com/
I enabled mypy and pylint checking to ensure we have some standards.
This would catch features supported in 3.9 but not in 3.6. It's nice
to have less __future__ type things by using 3.9.

Ian

> - Arnaldo
