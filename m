Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h257Hrbl"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12572137
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 14:09:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so3867a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701814154; x=1702418954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MfXx0SuFaYaxfBUsv9sabs9aUoX/sqeNUvNoJsvnlE=;
        b=h257HrblHX1P3yqAWDn75TVirujpd6+QLal+RX4I070x922N80jMteM3zdB30QEk/a
         jc7TKAMPVuGI1+PI6DYXrFwmVI181oUrhnTT3aFzk1NQXvIlZBkaABr/AJk/eQzgA3NQ
         CjEW8hLmBHbFSaRNnHx7B0PuurmepJOh+4p56LB0EF4Jbgb2Vhtw13R1P8KglywdfD3a
         8H75hNpbLX5uHuJuhm3ToU9cuSraQQBdpYc7fORHn6x+jiSc2cKK1gtIZ7njRqBMwSGx
         RqryfyGqSs82PWkMBbXBHfV63AO2YXFnZCuyqG3wtU82f9Yrdh3NMnO1GfpSzOreudUF
         xUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814154; x=1702418954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MfXx0SuFaYaxfBUsv9sabs9aUoX/sqeNUvNoJsvnlE=;
        b=KCibURDklonUNEkn50v/BL0aN0V8Xpn+wrO0C7j12fjj3+RQBfh74aSuaK/SLnJY83
         mSRUP3t35h1QZi/+qQQ+oFmIA0IEADPfldTVz05Kg3OJeIgNAshc2NE+lhywSLUeCm5v
         H8C1s3DSz4RszXrHvpLhIEzNCnirS8A+LkfAOo0wkZYV4cm5Vvc/9fesy5/O5NDwDdQ9
         FF2caOdFvVF/axGKbhLxD/paD/4dNp9lGDCPIq3cDXTOfw8ug8G4RQB2rhjVz6pLtMTb
         8I/HLe0xT2CPAcyasexOfFU22QNWnkSGopnQdEJs52i8yLBaEBZtdygOW+R3CRi8gTHD
         jc0A==
X-Gm-Message-State: AOJu0Yxj3ficnHy4fSnaBEegCqxoSO2Vi77x9RUm8liRCmKgWUcTv6ME
	zGji6yNwITmBC0hFptPN25SPDm1nBMSca/z+SC2q4Q==
X-Google-Smtp-Source: AGHT+IGFEpGOvnm0S40EH1LIvhCSLZo7DzOk0IVnTQfsfPAx/TKGVtoqJoCsLPt+JMA0HlaC/B7IyrBKnoR0DX7+Ktg=
X-Received: by 2002:a50:9f65:0:b0:54d:6a88:507e with SMTP id
 b92-20020a509f65000000b0054d6a88507emr30833edf.4.1701814154246; Tue, 05 Dec
 2023 14:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123160232.94253-1-atrajeev@linux.vnet.ibm.com>
 <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com> <ZW+bIGC3r2dcTQUO@kernel.org>
In-Reply-To: <ZW+bIGC3r2dcTQUO@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Dec 2023 14:09:01 -0800
Message-ID: <CAP-5=fVAYnYd7yAQMRdQFoHyDK9SAd1jS6Tjh8QhOSU3Cymk_w@mail.gmail.com>
Subject: Re: [PATCH V4] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org, 
	adrian.hunter@intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:50=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Mon, Nov 27, 2023 at 11:12:57AM +0000, James Clark escreveu:
> > On 23/11/2023 16:02, Athira Rajeev wrote:
> > > --- a/tools/perf/Makefile.perf
> > > @@ -1134,6 +1152,7 @@ bpf-skel-clean:
> > >     $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETON=
S)
> > >
> > >  clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMB=
OL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-c=
oresight-targets-clean
> > > +   $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
> > >     $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-=
archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> > >     $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd'=
 -delete -o -name '\.*.d' -delete
> > >     $(Q)$(RM) $(OUTPUT).config-detected
>
> While merging perf-tools-next with torvalds/master I noticed that maybe
> we better have the above added line as:
>
> +   $(call QUIET_CLEAN, tests) $(Q)$(MAKE) -f $(srctree)/tools/perf/tests=
/Makefile.tests clean
>
> No?
>
> Anyway I'm merging as-is, but it just hit my eye while merging,
>
> - Arnaldo

Makefile.tests was removed in these recent patches adding support for
the OUTPUT directory:
https://lore.kernel.org/lkml/9C33887F-8A88-4973-8593-7936E36AFCE1@linux.vne=
t.ibm.com/

Thanks,
Ian
