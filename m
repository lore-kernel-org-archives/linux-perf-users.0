Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEF2A1D3
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759509; cv=none; b=KyoVcOsUGRa9eu6yPgHyQNC3N/SdfF7pkOWj9gKAMc6WY06mYCTeuAp9hCntqKRiDyufC4L/0mP82ALbRxMgfuUANypXiqljV1DfsQ0VtT9d3yMdPZfcdDSXytWn1pj4NadBXC/YpRGQTxxPbw1cX9IjwOpDTWMsvhnEa1deGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759509; c=relaxed/simple;
	bh=sBw3tnPpJTLs8X9kDSlr8eMkL+MLf9/ygoYTPJf9ypA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX/ssCL4Lcxc9zVJGF8uOvTlDZR5DpgByxsOBbPEoUfxQh2pR7icBR164wlp9wriRPbM8Bd7QOrrxTxAUzcA85O/xYxV6W/Xm6Yw+DDbCm4Mgi+cfqk8sJIGgWi7/t7DfkY9WHCWhmSJEPp1bLNIVR2HojqE2jHTlSvtRH8bYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kinSnjrB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kinSnjrB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a1a662a633so141625ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727759507; x=1728364307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QirzQMHPIzDmfiGfgsuTlyPgvYJU4lNtzMZ+9NX7qIw=;
        b=kinSnjrBV0ZJNmYhPY2HSMgGdWK/JQxTwX+f+Rha/T34TMIQT4cuzoobrI5vSJaHrU
         Kd97j75MVXPY+jaYgpkUgaiWjI+S/y/uiRqHxt3Oaw2ju19aRmhW3FrIc/c6yoCUyQSH
         3DWpDPuKWOtuqeRILfuwAWQRHWfU1vaoa9AbLa8HFAytMM43VP3FIcuj8Zz0C6BqKbwi
         Km0N6uW4hqZtIzRYxC2a9ltk6EcTf4x8XyaeVNwwRAyIFb83BFoyQ2UF+Y+Yr+gw0x8j
         IpUWcrrbDki5ub+fkZ9mOvA73sqpGwzamNxNBa3O+KiBWZZ3CJBoFkL/8bbGjdtd+ljF
         YoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727759507; x=1728364307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QirzQMHPIzDmfiGfgsuTlyPgvYJU4lNtzMZ+9NX7qIw=;
        b=KuwAzhxkV/A4XEICDRodETj7gFisqFZZ30CcJVSSKxcSSNbvQQChYVI5sqLvhPkSgg
         nbce/MjrCtwzY541aQ7UjiJm5NaRfUYv8xHapkg/pHklwIeHpZkht7krTsnGmZ/mtNCo
         lAWSRlc+0YCqPD2M8nRNXFho7MICuPtcFrm4MKMFH9Dzvc0KpY8eqCSm/l4Tq+EzFS8t
         1bZrB+eLRiCNFj1ditGUTbpF7iH9D8v0TSUd2U41xluyGJYxA52Ny2gpqLaFRvMpDgQm
         aonrvxPy4RU6CZsMwWeqsbh/Ogh2Uyy6lAEWnFFeqo3SjWcDXCtEZI7P+hxZ0mmrnMRt
         LfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzWwPAwchV4aR4pLRTPs39TfEftGrT4XNmH/oRO9EOTD8Vz+YvWqQ+m4nj2JfQIZcgjUkfkxLarkJ9DyuEq8F3@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDB3xELLt6osYK7rMwZeoffRkhXnU/wrW440ep39B/nsiER0P
	8KpBqFi5eBLaw56abPM5hJIyDazDUuKV8KLFVVb6YVUcfrzoTxO+Q8FoGClNIcQyfaeqWkcLtVD
	0eCCrkX0ZDu7oqOHJPw0Fo48UpOt1sORZRQgi
X-Google-Smtp-Source: AGHT+IFZ4pG8RfNF8JoC/eN1QNWIj760sgGiMa9gGZ4D5RwiBD6tX0hdV398+In4vanPXRWmUStjqRzVFsO9jp90bY4=
X-Received: by 2002:a05:6e02:1749:b0:3a0:8efd:f48e with SMTP id
 e9e14a558f8ab-3a3607ff673mr1628495ab.1.1727759507240; Mon, 30 Sep 2024
 22:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <ZvMEGn5RIWMZNvFc@google.com>
In-Reply-To: <ZvMEGn5RIWMZNvFc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Sep 2024 22:11:34 -0700
Message-ID: <CAP-5=fUP07h=RFQ7n0pwzeK4-DgD2st3tfYxT0_e-y9GOst4fA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] 2 memory fixes and a build fix
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Sep 23, 2024 at 05:37:17PM -0700, Ian Rogers wrote:
> > I was looking into some lsan regressions and a latent issue with
> > libdw, creating these fixes.
> >
> > A thought, we should probably simplify the libdw logic but rather than
> > do it here I'll do it as a separate series on top of these. The issues
> > I see are:
> >
> > 1) dwfl_thread_getframes is used to test for the presence of
> >    libdw-dwarf-unwind. The blame date on this function is
> >    2013-05-30. As the function is 10 years old I think having libdw
> >    implies having dwfl_thread_getframes and so we can just merge the
> >    two pieces of logic instead of having different feature tests and
> >    ifdefs.
> >
> > 2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
> >    let's just make libdw tests test for this and make having libdw
> >    imply dwarf_getlocations support.
> >
> > 3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
> >    just make libdw tests test for this and make having libdw imply
> >    dwarf_getcfi support.
> >
> > 4) in Makefie.config feature-dwarf is a synonym for libdw support. I
> >    think using the name libdw is more intention revealing as dwarf can
> >    mean multiple things. Let's change HAVE_DWARF_SUPPORT to
> >    HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.
> >
> > 5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
> >    0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
> >    on the NEWS file). Let's remove the #if and ensure elfutils feature
> >    tests for at least 0.142. If someone were using an incredibly old
> >    version then they'd lose some elfutils support, but given the 15
> >    year old age of the library I find it unlikely anyone is doing
> >    this. They can also just move to a newer version.
>
> Looking at the map file in libdw, the latest addition was 0.158 for
> dwfl_thread_getframes().  Probably we can add the version check to the
> feature test to make sure if it has all the required APIs.
>
> https://sourceware.org/git/?p=3Delfutils.git;a=3Dblob;f=3Dlibdw/libdw.map=
;h=3D552588a94c0c1a1f2fd5b973553c784026e6de14;hb=3DHEAD#l274
>
> >
> > From the mailing list I notice also overlap with the last patch and
> > this series:
> > https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedan=
ce.com/
> > Simplifying the libdw support will address some of those issues too.
>
> Yeah I noticed that too and feel like it should go to perf-tools tree.
> Probably it doesn't clash with this so I think it's ok to have this in
> perf-tools-next.

I think the comments wrt libdw are covered in the series cleaning up libdw:
https://lore.kernel.org/lkml/20240924160418.1391100-1-irogers@google.com/
so these fixes should be good to land?

Thanks,
Ian
