Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274128FE
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 04:07:11 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E921BB83
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:07:09 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4195fe5cf73so36301cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695787628; x=1696392428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0nMoCs35unZfclTu3DKp3uZsoT22xTXBwaLiGdkdWQ=;
        b=GmrGZwQOhEVqm+OG9/SbQUKxe/HC3FGo0BMMHGQDUJUicFFi6E7LLg49haja2g7jR0
         GH7AIzWgxZgaKiCgEqcbMpiIuteR2fXKdx5V7a6vl7u5V7wRkBoD81BQhUdAI1SBSHFW
         E9BvHRjDotaAohAfYpaDEj0a1BAdFP3qNyy8msx5pdwMBUw0t+zy/NiRCh0NQCXFVuND
         Ff4R6Eee2C3F+EGpBjkSBgLYHFeoKrT0pXeLO8eVUFrZ2JsblxTpiF0jvBSG1LLw3RWN
         ldmY3324yh5Zfbn+h6AU39p3QYDWBn1VmVY5ByHmmZ8sHWcdE/6DR2fkCnGjRh1Dip3C
         bHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787628; x=1696392428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0nMoCs35unZfclTu3DKp3uZsoT22xTXBwaLiGdkdWQ=;
        b=j6s3uxUu2v0VzNqv3AAog1XXd1yZkbFbQL8In+kn1uhdvrfso2uHY3lNDMwPDgLbrb
         LXciPcjjEdixXy735nf2W1Uf+turZ0tdE+JepM1YSgPzreC4Ty11eoHHb3TBHo7gjjyn
         PEZ3lniO5noLXLMawKL52ZuuwXMK8GDxK6o63MZIDiV15kbMnH2SV70ZqezfWp9JpsUP
         k08BRcbMnE5N49zE0/JC/ZirA1jifjTvy/JIKtOXFPIdmYCPKeQPZU0hbQqsr6DJBL57
         8DJbnL1ocAuNOQiLQ6v1IqC8tAlVRMuDcnQrNi+2VZr8rseZaRRbdm7FVvHMUFhp6DHT
         M6AQ==
X-Gm-Message-State: AOJu0YyqNDJwqmiLkoFtNsULKC0t4aibgewxhJl5AuZBwAyxQv1oglMA
	+VWuruOsH+p2E2lVG5UhWvYVd0AWMlEzzlAk10ZVNw==
X-Google-Smtp-Source: AGHT+IFCXgdLLs1mW7I4BlBzVeMEB6FdpuzGm3k488f4N7W5WLbOWSAiS2RMjWpKOJAXI6lI/9CZr5elbMW47291M04=
X-Received: by 2002:a05:622a:188c:b0:410:9855:acd with SMTP id
 v12-20020a05622a188c00b0041098550acdmr483377qtc.14.1695787627958; Tue, 26 Sep
 2023 21:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com> <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
 <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
In-Reply-To: <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Sep 2023 21:06:56 -0700
Message-ID: <CAP-5=fW7dsMw0i7N-oQ7dcz9sFx1hAtZCpsxuH=NqMz+h+i3ZQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To: Namhyung Kim <namhyung@kernel.org>
Cc: Wyes Karny <wyes.karny@amd.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandipan.das@amd.com, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 3:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 20, 2023 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Sep 20, 2023 at 5:24=E2=80=AFAM Wyes Karny <wyes.karny@amd.com>=
 wrote:
> > >
> > > The perf_pmu__parse_* functions for the sysfs files of pmu event=E2=
=80=99s
> > > scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> > > ("perf pmu: Be lazy about loading event info files from sysfs").
> > > However, the paths for these sysfs files were incorrect. This resulte=
d
> > > in perf stat reporting values with wrong scaling and missing units. T=
his
> > > is fixed by correcting the paths for these sysfs files.
> > >
> > > Before this fix:
> > >
> > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >    351,217,188,864      power/energy-pkg/
> > >
> > >           2.004127961 seconds time elapsed
> > >
> > > After this fix:
> > >
> > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >              80.58 Joules power/energy-pkg/
> > >
> > >              2.004009749 seconds time elapsed
> > >
> > > Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info file=
s from sysfs")
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Applied to perf-tools-next, thanks!

Thanks Namhyung, I think this should be a candidate for perf-tools so
that 6.6 doesn't regress for sysfs events.

Ian
