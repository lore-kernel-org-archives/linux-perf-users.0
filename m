Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE911731
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 23:51:28 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7019EA7
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 16:51:26 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79f9acc857cso303200439f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 16:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772286; x=1696377086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdnU4DuoDJdYmnW0BzUCEF+B7Lkxwtj+10/qp8KP4eo=;
        b=bQZuO9zd9BdAjqKNTyN8UCscX6492qlbNh8aezQexMkCIMnnHy0eMksJGRaiEerdB4
         yM6CcVWFc4+y2h2uiffFg5HhWszs5D9E5wmZkX8qXOD/UzeVAKBckwBGBF8E+yR31Rpi
         fle7+KsMKi4UKmegmQBmsipMmb4a0mvMB2MPjs9nGgDIo81Rz0q1xCzMs7hIp6ZiVFMJ
         yij0upetmucDHbSJOlSRlbIo9WYbBeLm8+pgmzCiWqsRDIHwcE2JfvJvwd3dF/G12Vcz
         YmFkoPWBfPxJcVytj1qy6oBuWlcsOdcMUfCzynv/PktE9nUxTwwyE0LrsdnHXJnCrCjf
         70wQ==
X-Gm-Message-State: AOJu0Ywu1NE+a2/9FuFTRPC4SVsBKhJlUQbMao0JMpYMjt5X2AV+T/eQ
	rbpujv43e9k/WLqxrdsQvmlbu21IM9/gxuAKKGs=
X-Google-Smtp-Source: AGHT+IEP9vVIywM7SjQaBzy8Ky3U1xznU0lUsv7UYHOA7Bva3KIpj9g+j817av2nW+NyqppUhTx4RSBqY6iEnhNNaTM=
X-Received: by 2002:a05:6602:185:b0:786:ca40:cc88 with SMTP id
 m5-20020a056602018500b00786ca40cc88mr340903ioo.11.1695772286141; Tue, 26 Sep
 2023 16:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914171827.98507-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230914171827.98507-1-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 16:51:15 -0700
Message-ID: <CAM9d7chpQ-t72+wsv0qrLsLK9yJ5x77qapqN3+9tKHqT8246Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/perf: Add new CONFIG_SHELLCHECK for detecting
 shellcheck binary
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Sep 14, 2023 at 10:18=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> shellcheck tool can detect coding/formatting issues on
> shell scripts. In perf directory "tests/shell", there are lot
> of shell test scripts and this tool can detect coding/formatting
> issues on these scripts.
>
> Example to use shellcheck for severity level for
> errors and warnings, below command is used:
>
>    # for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellche=
ck -S warning $F; done
>    # echo $?
>      0
>
> This testing needs to be automated into the build so that it
> can avoid regressions and also run the check for newly added
> during build test itself. Add a new feature check to detect
> presence of shellcheck. Add CONFIG_SHELLCHECK feature check in
> the build to avoid not having shellcheck breaking the build.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/build/Makefile.feature |  6 ++++--
>  tools/build/feature/Makefile |  8 +++++++-
>  tools/perf/Makefile.config   | 10 ++++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 934e2777a2db..23f56b95babf 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -72,7 +72,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libzstd                                \
>          disassembler-four-args         \
>          disassembler-init-styled       \
> -        file-handle
> +        file-handle                    \
> +        shellcheck
>
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> @@ -138,7 +139,8 @@ FEATURE_DISPLAY ?=3D              \
>           get_cpuid              \
>           bpf                   \
>           libaio                        \
> -         libzstd
> +         libzstd               \
> +         shellcheck
>
>  #
>  # Declare group members of a feature to display the logical OR of the de=
tection
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 3184f387990a..44ba6d0c98d0 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -76,7 +76,8 @@ FILES=3D                                          \
>           test-libzstd.bin                      \
>           test-clang-bpf-co-re.bin              \
>           test-file-handle.bin                  \
> -         test-libpfm4.bin
> +         test-libpfm4.bin                      \
> +         test-shellcheck.bin
>
>  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
>
> @@ -92,6 +93,8 @@ __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(p=
atsubst %.bin,%.c,$(@F)) $(
>  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bi=
n,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
>
> +  BUILD_BINARY =3D sh -c $1 > $(@:.bin=3D.make.output) 2>&1
> +
>  ###############################
>
>  $(OUTPUT)test-all.bin:
> @@ -207,6 +210,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
>  $(OUTPUT)test-libtraceevent.bin:
>         $(BUILD) -ltraceevent
>
> +$(OUTPUT)test-shellcheck.bin:
> +       $(BUILD_BINARY) "shellcheck --version"

I don't think it'd generate the .bin file.

Anyway, it's a binary file already.  Can we check it with
`command -v` and get rid of the feature test?

Thanks,
Namhyung


> +
>  $(OUTPUT)test-libtracefs.bin:
>          $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/nul=
l) -ltracefs
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d66b52407e19..e71fe95ad865 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -779,6 +779,16 @@ ifndef NO_SLANG
>    endif
>  endif
>
> +ifneq ($(NO_SHELLCHECK),1)
> +  $(call feature_check,shellcheck)
> +  ifneq ($(feature-shellcheck), 1)
> +    msg :=3D $(warning No shellcheck found. please install ShellCheck);
> +  else
> +    $(call detected,CONFIG_SHELLCHECK)
> +    NO_SHELLCHECK :=3D 0
> +  endif
> +endif
> +
>  ifdef GTK2
>    FLAGS_GTK2=3D$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --l=
ibs --cflags gtk+-2.0 2>/dev/null)
>    $(call feature_check,gtk2)
> --
> 2.31.1
>
