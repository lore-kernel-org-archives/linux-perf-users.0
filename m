Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5D1391
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 05:10:02 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AAE4
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 22:10:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50302e8fca8so3562e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696309799; x=1696914599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuCQrq07t28e/w8SE3k84A5e3jrsGC5/Njzxci1gOnM=;
        b=vImCd6G1Y+pKOMGE2CajqhHxMzgQHmJugXVu3fvu0SAGfc+M0NFkn7DcVlJpSjYuFU
         vM2EZkN7CNWLF/LIH1az4Gsz5u8F28APE6mfkCwKPpzRff3NWeWlwsxR2ZDh5lejsDCj
         Pl0bPQyJV7X46dAeb5TOfPiLy3tKrT/IvtY95XZaX9+j/eJvRK/5tBemBHms5a6h2TT8
         TZkQkGoRooRxg6L2CU7Fycy4iBUCW8GQ/6Kdn7/jmm8hmzCohTz8PTUkZzgeLec2Yzbc
         Pe6VaRp3rZyPluUirJXpj6EaU3+F8U9WTK6pPzzT72lcrQpzMpaIpnADeD4G72675Syx
         DT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696309799; x=1696914599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuCQrq07t28e/w8SE3k84A5e3jrsGC5/Njzxci1gOnM=;
        b=Iy8Xg5f1y4YPzTA3yo6+DmxbFvMhnJyaZ08jYBiscXPXBfdOGhwGmeLc3j3HFOHH6B
         hX7q9TwXniLpq/0UUszaX1st//IVTlKFk4Hu5/jrRQqf2URBltE7RJ/moWRxVBJm/mcz
         tiHKo4HsJsGmxstIBn4+5nloUxWJ8qCfJRYt+x8UFIbaWQmb9P0Duvp+kKfR/W0xtk2y
         hAPAuzt5RqjkU9tfhQ0ZSwFZgpMbJwDezoIjw/htxVExgS4ljQRUVbzURnrzTln0aV4i
         q86nARgX6G2y/LshV6s+fZvvxTsGBL37Jcp+pgsbwqBAOdwWiQxl2tyl86Gkx0JdGhVK
         exfA==
X-Gm-Message-State: AOJu0YwS1wpiwKV6kyu4U8gro22ZvlxxHCXUjlPPCriT9nQ6V5v580N0
	B5dKPXaYf7f/qBudTNuhWX1UCZfKUfZHQ0/LJI04jQ==
X-Google-Smtp-Source: AGHT+IFyKRAs1nSnT7gvq2u//Gg7pZ51XcU9iClk/bEw0hlTaiaSYD7AI5ZrfWX42ndTU40I/DwZlI/gmpWW64Pxa7A=
X-Received: by 2002:ac2:4ade:0:b0:505:7c88:9e45 with SMTP id
 m30-20020ac24ade000000b005057c889e45mr57996lfp.0.1696309798688; Mon, 02 Oct
 2023 22:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930060206.2353141-1-irogers@google.com> <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
In-Reply-To: <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Oct 2023 22:09:47 -0700
Message-ID: <CAP-5=fWDzjtkf7cSZVgSYUzFohH0tp81A7muke_+bH7rgnGJxw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid system wide when not privileged
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Sep 29, 2023 at 11:02=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Switch the test program to sleep that makes more sense for system wide
> > events. Only enable system wide when root or not paranoid. This avoids
> > failures under some testing conditions like ARM cloud.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> While I'm ok with the change, I wonder why it doesn't have the same
> code structure as in the stat_all_metrics.sh which checks the actual resu=
lt.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

The metric group isn't printed when we print the metrics within it.
This could be changed.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/tests/shell/stat_all_metricgroups.sh | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/pe=
rf/tests/shell/stat_all_metricgroups.sh
> > index cb35e488809a..f3e305649e2c 100755
> > --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> > +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > @@ -4,9 +4,21 @@
> >
> >  set -e
> >
> > -for m in $(perf list --raw-dump metricgroups); do
> > +function ParanoidAndNotRoot()
> > +{
> > +  [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_parano=
id)" -gt $1 ]
> > +}
> > +
> > +system_wide_flag=3D"-a"
> > +if ParanoidAndNotRoot 0
> > +then
> > +  system_wide_flag=3D""
> > +fi
> > +
> > +for m in $(perf list --raw-dump metricgroups)
> > +do
> >    echo "Testing $m"
> > -  perf stat -M "$m" -a true
> > +  perf stat -M "$m" $system_wide_flag sleep 0.01
> >  done
> >
> >  exit 0
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
