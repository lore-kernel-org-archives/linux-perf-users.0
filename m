Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303242C9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A2A4
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Oct 2023 22:22:33 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso2243891a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Oct 2023 22:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696828952; x=1697433752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKDjDbJ7FjBDQQgX7EI5ljX+mPg09NnPyujEusdUD2c=;
        b=tvx3ONcqVTf3uEaDJMQCmWQ+YxUKqDEfmcgFjD0ES04nnwtjtqblU9TD2b5Z4SjSnC
         CjhH2PLD240FljW8lP19Q9dX1n2OmMVdi6bkXNZVdAsYuz/XT7fVUIgNyGn074CwVIh5
         AMRe7spSi6IkpJl8tIKIArwLuShST1dWwhDy8X0aZ65iu8jWnfHwTu8GAEsEr9LH5WYD
         GObWH+ygSNy+sfbnLNGLdiwj/bozDkILBKVU9lQtfF5aOtVr/Mj0RF0zgMww5C8PMkdG
         XGzLmxG2ifUB3QD1HS3qP0GhZ7Bl3y0dKUQS5z+W6YV/zJNAEC0noazw5QHACQ10arS6
         cVaQ==
X-Gm-Message-State: AOJu0YzzrW+VdqiPzCOwUC5PnyPzXyBg4PCtjAnU6dw1+u5LZOu1u9ik
	QbgCIPQe+jtnDEcJKJsicWdfCBItPcnh0/hmNUE=
X-Google-Smtp-Source: AGHT+IENZzLxeNSXadpD69/vTTWQ9pE2S1iKF8DEI/1CBQYLuymTXAKGnyb44p79qCUIi+AxalU9sd7YfmeRpKOzu4w=
X-Received: by 2002:a17:90b:1c83:b0:274:616e:3fc4 with SMTP id
 oo3-20020a17090b1c8300b00274616e3fc4mr11154380pjb.34.1696828952468; Sun, 08
 Oct 2023 22:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928075213.84392-1-atrajeev@linux.vnet.ibm.com>
 <CAM9d7cj0iLdrV6EYmo_oC9M_32fuRVv_geBPz4GJv41jZR5WNQ@mail.gmail.com> <63F6D59C-3C40-4E39-BC63-4CB2DDAD0F47@linux.vnet.ibm.com>
In-Reply-To: <63F6D59C-3C40-4E39-BC63-4CB2DDAD0F47@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:22:21 -0700
Message-ID: <CAM9d7cjRD5TwgTCxb+Nc3xM6QJbHBu8=M-QMh=MkH+k1jOeLvg@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] tools/perf: Add text_end to "struct dso" to save
 .text section size
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.vnet.ibm.com>, 
	Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 11:47=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 03-Oct-2023, at 9:58 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Sep 28, 2023 at 12:52=E2=80=AFAM Athira Rajeev
> > <atrajeev@linux.vnet.ibm.com> wrote:
> >>
> >> Update "struct dso" to include new member "text_end".
> >> This new field will represent the offset for end of text
> >> section for a dso. For elf, this value is derived as:
> >> sh_size (Size of section in byes) + sh_offset (Section file
> >> offst) of the elf header for text.
> >>
> >> For bfd, this value is derived as:
> >> 1. For PE file,
> >> section->size + ( section->vma - dso->text_offset)
> >> 2. Other cases:
> >> section->filepos (file position) + section->size (size of
> >> section)
> >>
> >> To resolve the address from a sample, perf looks at the
> >> DSO maps. In case of address from a kernel module, there
> >> were some address found to be not resolved. This was
> >> observed while running perf test for "Object code reading".
> >> Though the ip falls beteen the start address of the loaded
> >> module (perf map->start ) and end address ( perf map->end),
> >> it was unresolved.
> >>
> >> Example:
> >>
> >>    Reading object code for memory address: 0xc008000007f0142c
> >>    File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
> >>    On file address is: 0x1114cc
> >>    Objdump command is: objdump -z -d --start-address=3D0x11142c --stop=
-address=3D0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
> >>    objdump read too few bytes: 128
> >>    test child finished with -1
> >>
> >> Here, module is loaded at:
> >>    # cat /proc/modules | grep xfs
> >>    xfs 2228224 3 - Live 0xc008000007d00000
> >>
> >> From objdump for xfs module, text section is:
> >>    text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4
> >>
> >> Here the offset for 0xc008000007f0142c ie  0x112074 falls out
> >> .text section which is up to 0x10f7bc.
> >>
> >> In this case for module, the address 0xc008000007e11fd4 is pointing
> >> to stub instructions. This address range represents the module stubs
> >> which is allocated on module load and hence is not part of DSO offset.
> >>
> >> To identify such  address, which falls out of text
> >> section and within module end, added the new field "text_end" to
> >> "struct dso".
> >>
> >> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> >
> > For the series,
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
>
> Thanks for checking Namhyung,

Applied to perf-tools-next, thanks!
