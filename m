Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4D3CB546
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372738; cv=pass; b=VyqOMzHp36qBhDIX9sQnknBchp7qHOSkN0kNFfYYZ4xkQ9gyVoi4q4JgLo5NFBFzpimjfMvUnV6AhEBjWzCAB9hpdZVkq0EWAjIgPSONIVIdLnf8GBh+vha1Nv/90spkvozjHkjq+n6ETd052h7ODeP9Z5XLYN4di6QUJnIY5KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372738; c=relaxed/simple;
	bh=ZiphONsMPuG6c8Tg3TIHxlnKpQCKDmMlorG/SmhRn30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJiMhvzuKhU3dpPS5qOL6140OTXjnTaXTuBIhbmUgQIh99vtNPiU2/n1budcc+t9mwEYowJOfltiEHGV7+Bse6EeAV2iCxmQjyNo6dDJ6LuSG1tfMog7Dj+SgrRuhka7mROsHd7OyV+xekz+4umki0VIYWDGPSjTOat5hRn0T+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krnKP70Y; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krnKP70Y"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52faa58bff5so92111cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 14:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790372732; cv=none;
        d=google.com; s=arc-20260327;
        b=MrcHRMMz5eD/VdnOky3unSL7AY+TdiOYhsfUBbAUdKLuwn+oC021d77GiZtC8glaGg
         CAx0gF7jxN8DwUBHhHzNmd21c7SmAboCeMm4m5/FVE6Sjy7r0pHFxJe0dtKBx7hzLwHn
         qPDqNR4gX5vGdk3KVnVPlaBCjF5khe81y7sID+czxYrfC95P/8cJqaJXl7MaHoqoT/1T
         THKaIyvzD4/pva+o3VfBshDLosw3pZa8Si9ac7nEnaCsWlrv9/MFjfoSYcp/Ba3SMn0h
         Oz2M8iwDH1NVnmTccpIUN6SxpF99ym+gvvMr5mtSvkwATk5MwpklrztHtxuRLknyOzRs
         QKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvCHE5eJ9VqgmIWTdjvSHxmVJYniXRdts205qRwHFtU=;
        fh=+oZrkPPBLoHOxjVtuC2hy6m0x2gOlzYAK7FghrzXDJY=;
        b=OTXLmz+Sa3wmp66ARhA84W53bGKuY+my8hO2QN05gQZQxPn044V477OgRFzDoVlGpx
         eOqz+R/Ftq4qrfsTX/U3e7bzaEGw3YOp5YCT+MgZGObhsoKv9d0nHcCIIbIoQgdLWOeE
         YbN15N+VS1rISDEiypIYUOPxJutjiHAxtxDEVBtc7NSKd18+kBGk//Ewj5IU1EtlS1VC
         eIxQ9rTryev1Nt2gvHqb+akJRLIyR8atHW8bhz7A9YowLgI1q/gIKDL2d0AxWPnLUo6P
         wVosZZr/N2jt2kpMw/TFsJjcn79FuB+hZkkCKacLVsCvY6QQQefVu/ulNVVGCh6ux/pR
         Xogg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790372732; x=1790977532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvCHE5eJ9VqgmIWTdjvSHxmVJYniXRdts205qRwHFtU=;
        b=krnKP70YIpxfzVvV31SerySDlfPArF+icZ6CSdWULJ1+y97A0HVgX6TQJCB/OfChrt
         NzJ1UEw+0N3jZTcjaf85ueJlMfSkUgKwUoGIN6/2Rc7kDtck7LssFSIg2pitPpt3BDSw
         LiPcEaWd/mraikQFVHeQVbgFAB6C675gYvS1/pVXDlg6kCHBlaVi8xWP8JKEQu6dYCeI
         iWpimVTL4cxHXSVJEMEcYmwj8733OBswnBeUx8TZm+2s3GNrbTe7eDPWc0vfgh3dEOKZ
         peLnkwuMFzvnD7evJxq+1272/oslytyQ4ywvqtt/cENEq0eaYN1cYpYHThwMdru0yLja
         YnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790372732; x=1790977532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvCHE5eJ9VqgmIWTdjvSHxmVJYniXRdts205qRwHFtU=;
        b=NHCqqNu3D+xoi7Al43UjNLyDj03RN522IHIxGW113HpiBgxDOZoZDidUEDvcu3ZSuK
         EeS8fDjkA0XTjyjIq+3Lf+D6nptRM9j89vrAJCz/KzCTeU9B8MRihOkeJ5GGJCZkNO4h
         v5+XSb7Mvwvfn7wVlEjDyC0Zw0hHgMn+wFeNtYJADixt8SCYLZO+3M3r93Ym9Xw4tA7F
         xOuvT9t/Ft0DGBQG5+aoH0HT0/d8glwzvVxdSxCaQqlfj0i5J6i90xNC38e5OwVMjnm6
         lPZZKc5WpStbc6jNvvLEP4c9vdwZ68CmVuJCpPpgURx+cbmOf+OjPpXEXu7/PEQLHVTw
         f/kg==
X-Forwarded-Encrypted: i=1; AKwUvBy60O8SQRlAZios2/rn+zVgSpalgWHabxZiRkhPfCAf8lZLPjyTkRf7e1WcMf+MSgz/5iAr06tsFA31PN+z7A9V@vger.kernel.org
X-Gm-Message-State: AFuF++lFGtnjPzJSR1uzS1tNak7A9lhRd0gO79tM6mvgoYvUDC91lDoJ
	yMNz+ksQHZ40Ki/FfCvrK62nUrGZIaPJxKfHRAxr+gb3VkaX1voSli5y/NHItcLawP5dJQB7KxG
	xlvJoSSQW+mNWlwqF+G1LwwPZO2PcXKqJ7aGJcpKO
X-Gm-Gg: AYBFou1xBNEN97yPZoKDKfE56OLqZTnBQfivNCucGMR/dXX5AkfniaO/IIHyS6o5qch
	WDIDo9C0cnJ9zA/k1ji7yvELu6TKP3DWD6Qj21oJBD7ebxPxZp84XzjHzP1cs+841F4Akxis45E
	QxY52JJFVqImtjEsNSMx2YFFOn6W/O2qEgCDQ1eJZD+Dfh/NV/yJQbhpdDpjLz/KYF0PfvmfBzH
	brVlG9NOprCIKc1C9iSR10PCpk69NVMFZ4fzvWXf/gDgW8MRhbg9ud+F3TdvlERma7e6lDUyqzm
	ITOo5jJpSbrx89p+IIvC1X3U3y16fnm3jBuvEhCPdp1P7dZ1grZo+SwX8YwjQtpobCyyVSxad0D
	zzGxIytjnUkrcIUyZ7yPd
X-Received: by 2002:a05:622a:1a8f:b0:532:c8ca:5ae9 with SMTP id
 d75a77b69052e-533226f9f89mr1891571cf.11.1790372731275; Fri, 25 Sep 2026
 14:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <20260923090007.GJ200420@e132581.arm.com> <CAP-5=fUn8hafFn_RJs0vgaZKmeGEvWqRwtC4arYrCgogETXUJQ@mail.gmail.com>
 <20260924154151.GM200420@e132581.arm.com>
In-Reply-To: <20260924154151.GM200420@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 14:45:19 -0700
X-Gm-Features: AclHuK-NnG2KsjQ2FK_UJ-lBInkoXvYPDJLPwdVE27RSY365Y94cjZXuWEYu2LE
Message-ID: <CAP-5=fXTYJMTtaTBZf5g6UV_-pcx0rdM=oJM=odn_dhDaOx=pw@mail.gmail.com>
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf module
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:41=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Sep 23, 2026 at 06:40:57AM -0700, Ian Rogers wrote:
>
> [...]
>
> > > > @@ -44,8 +56,8 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|=
mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
> > > >  if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
> > > >       echo "Testing kernel disassembly"
> > > >       perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K --=
 touch $file > /dev/null 2>&1
> > > > -     perf script -i ${perfdata} --itrace=3Db -s python:${script_pa=
th} -- \
> > > > -             -d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2=
> /dev/null > ${file}
> > > > +     $PYTHON ${script_path} -i ${perfdata} --itrace=3Db -d --stop-=
sample=3D2 \
> > > > +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> > > >       grep -q -E ${branch_search} ${file}
> > > >       echo "Found kernel branches"
> > > >  else
> > > > @@ -56,8 +68,8 @@ fi
> > > >  ## Test user ##
> > > >  echo "Testing userspace disassembly"
> > > >  perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file =
> /dev/null 2>&1
> > > > -perf script -i ${perfdata} --itrace=3Db -s python:${script_path} -=
- \
> > > > -     -d --stop-sample=3D2 2> /dev/null > ${file}
> > > > +perf inject --itrace=3Db -i ${perfdata} -o ${perfdata2}
> > > > +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=3D2 2> /de=
v/null > ${file}
> > >
> > > The perf script command is replaced with perf inject and a Python
> > > command. I learned from the above that we can pass the itrace option =
to
> > > the Python script.
> > >
> > > This is fine with me. I'm just curious why we don't use a single Pyth=
on
> > > command here.
> >
> > A single Python command that would handle both the itrace and file
> > processing? We could. Having the script command also perform an
> > inject-like rewrite of the data seemed less obvious to me than just
> > having perf inject do the work and then running the script. It does
> > mean a change for people using the script, and two commands could be
> > less convenient than one. We could expand the Python module "session"
> > code to include the ability to rewrite itrace data specifically for
> > this script. I'm hoping that we can have more composable perf_tools in
> > the code, similar to the ASLR code.
>
> > It would be nice to add itrace support to the Python code with
> > composing tools in mind. I was just putting off worrying about this
> > for now.
>
> Sorry for the confusion. I should have made this clearer in my previous
> reply.
>
> I was referring to this change:
>
> +     $PYTHON ${script_path} -i ${perfdata} --itrace=3Db -d --stop-sample=
=3D2 \
> +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
>
> If itrace processing is not currently supported by the Python code,
> wouldn't adding --itrace=3Db here break the test?

Thanks Leo, so I misspoke before. The LLM already added the itrace
support into the Python session API in patch 9 ("perf python: Add
Intel PT call_return and itrace capability"). It  adds `itrace`
support directly to `perf.session()` in the C extension (calling
`itrace_do_parse_synth_opts()` on the session's `itrace_synth_opts`),
and `arm-cs-trace-disasm.py` defaults `--itrace` to `"b"` and passes
`itrace=3Dself.options.itrace` when constructing `perf.session()`.

Because `arm-cs-trace-disasm.py` already defaults to `itrace=3D"b"`
(matching commit 89db7f0db172 ("perf cs-etm: Filter synthesized branch
samples")), passing `--itrace=3Db` in `test_arm_coresight_disasm.sh` is
redundant. In v4, I will remove `--itrace=3Db` from
`test_arm_coresight_disasm.sh`, add `PERF_ITRACE` forwarding when
`perf script --itrace=3D... <script>` is used, and fix two issues found
while inspecting the CoreSight disassembly flow
(`symbol_conf.vmlinux_name` initialization order before
`perf_session__new()` when `--kcore` is present, and recording the
initial `CS_ETM_TRACE_ON` sample's `sample_addr` before filtering `dso
=3D=3D '[unknown]'`).

Thanks,
Ian

> Thanks,
> Leo
