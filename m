Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C0620
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 00:16:09 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B11F31
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 17:16:07 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79faba5fe12so261760939f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 17:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773766; x=1696378566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1iZ4LU82UOG96j2VBk+9ry3Jk5SAeQvNprBdriKjWE=;
        b=w0yDG7IxzbHSoyPjx3QT2YwpwmPBhaK7pcjnN+YXcKjPG/w1JxnSeOLn0riuKmLkQ0
         M8/qmidmFEjD6qp0q3H7LRPUDocuzI4hVThLWDimJc4BcMNoe5hLpibEKmSY3G/oGQtz
         BiAG4mtxn3+Orxd7SwhcZainRD1IoeLEL1nKQ19FTJBiommWkeCEh5OOjSHFkKkz98si
         ZteJckxi2vBAbkm4NpwAkl0HWK0MqW2nfMwNEcuZr/xcbzpvM2qGWJXNo7WEKJVrJg5x
         AncAAnE6UeWRxR69UNjg5hnIxfNqoIGcKWY3qxj6JSn0PGa+3+abeGFirMwkBHDjBMGq
         g7cQ==
X-Gm-Message-State: AOJu0YyMZ3M7JwXoyrxamMuRO3rNPWS8mVCccLgA7w3fp4mYpdI0d57p
	zlOE1loFpHeA9b5A1HqVoMwgtoaLs0tuHA8Z+P4=
X-Google-Smtp-Source: AGHT+IHjC5UMNeuTMvB33Sbl+4uRFJJxkKraQqgF0oif/NziwbXElCwaGRmlMkcuh/j1vmapPbBvGvFi6qT5WD8VFXQ=
X-Received: by 2002:a6b:e211:0:b0:78b:b892:e334 with SMTP id
 z17-20020a6be211000000b0078bb892e334mr441916ioc.11.1695773766267; Tue, 26 Sep
 2023 17:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915053752.3012-1-atrajeev@linux.vnet.ibm.com> <20230915053752.3012-2-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230915053752.3012-2-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 17:15:54 -0700
Message-ID: <CAM9d7cg+RcpXnhB7ZBzsUXKuXXd_nTfnFNMf9L_+LNm8i1d47g@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] tools/perf/tests: Fix object code reading to skip
 address that falls out of text section
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com, Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 10:40=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> The testcase "Object code reading" fails in somecases
> for "fs_something" sub test as below:
>
>     Reading object code for memory address: 0xc008000007f0142c
>     File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     On file address is: 0x1114cc
>     Objdump command is: objdump -z -d --start-address=3D0x11142c --stop-a=
ddress=3D0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     objdump read too few bytes: 128
>     test child finished with -1
>
> This can alo be reproduced when running perf record with
> workload that exercises fs_something() code. In the test
> setup, this is exercising xfs code since root is xfs.
>
>     # perf record ./a.out
>     # perf report -v |grep "xfs.ko"
>       0.76% a.out /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000=
007de5efc B [k] xlog_cil_commit
>       0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc00800=
0007d5ae18 B [k] xfs_btree_key_offset
>       0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc00800=
0007e11fd4 B [k] 0x0000000000112074
>
> Here addr "0xc008000007e11fd4" is not resolved. since this is a
> kernel module, its offset is from the DSO. Xfs module is loaded
> at 0xc008000007d00000
>
>    # cat /proc/modules | grep xfs
>     xfs 2228224 3 - Live 0xc008000007d00000
>
> And size is 0x220000. So its loaded between  0xc008000007d00000
> and 0xc008000007f20000. From objdump, text section is:
>     text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4
>
> Hence perf captured ip maps to 0x112074 which is:
> ( ip - start of module ) + a0
>
> This offset 0x112074 falls out .text section which is up to 0x10f7bc
> In this case for module, the address 0xc008000007e11fd4 is pointing
> to stub instructions. This address range represents the module stubs
> which is allocated on module load and hence is not part of DSO offset.
>
> To address this issue in "object code reading", skip the sample if
> address falls out of text section and is within the module end.
> Use the "text_end" member of "struct dso" to do this check.
>
> To address this issue in "perf report", exploring an option of
> having stubs range as part of the /proc/kallsyms, so that perf
> report can resolve addresses in stubs range
>
> However this patch uses text_end to skip the stub range for
> Object code reading testcase.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Tested-by: Disha Goel<disgoel@linux.ibm.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> Changelog:
>  v3 -> v4:
>  Fixed indent in V3
>
>  v2 -> v3:
>  Used strtailcmp in comparison for module check and added Reviewed-by
>  from Adrian, Tested-by from Disha.
>
>  v1 -> v2:
>  Updated comment to add description on which arch has stub and
>  reason for skipping as suggested by Adrian
>
>  tools/perf/tests/code-reading.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index ed3815163d1b..9e6e6c985840 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -269,6 +269,16 @@ static int read_object_code(u64 addr, size_t len, u8=
 cpumode,
>         if (addr + len > map__end(al.map))
>                 len =3D map__end(al.map) - addr;
>
> +       /*
> +        * Some architectures (ex: powerpc) have stubs (trampolines) in k=
ernel
> +        * modules to manage long jumps. Check if the ip offset falls in =
stubs
> +        * sections for kernel modules. And skip module address after tex=
t end
> +        */
> +       if (!strtailcmp(dso->long_name, ".ko") && al.addr > dso->text_end=
) {

There's a is_kernel_module() that can check compressed modules
too but I think we need a simpler way to check it like dso->kernel.

Thanks,
Namhyung


> +               pr_debug("skipping the module address %#"PRIx64" after te=
xt end\n", al.addr);
> +               goto out;
> +       }
> +
>         /* Read the object code using perf */
>         ret_len =3D dso__data_read_offset(dso, maps__machine(thread__maps=
(thread)),
>                                         al.addr, buf1, len);
> --
> 2.31.1
>
