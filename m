Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C2C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EE460F12
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhGWRr2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGWRr1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 13:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA4E660EFD;
        Fri, 23 Jul 2021 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627064880;
        bh=HaFshbfHZgqNHNDQcEHSqY8d1j1xYZH4fiC/lGShs2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCrlsRVc8pXKhcqz7MCxSxAehpyowqwPWDdWsxLavMC2RMf5O5KJ+i0OBbxczG5w8
         u1/nODLG6EbS3+N8d8mPJ32vos4BnXKs/4dqKHuTBoOfavDS8ZlBKPsa/TWbSSmXqB
         SygffDymBmkmUMsSv2LXCpQV3nN3IQ5b7Z5+FkhLLFjOYGi6RxOTV6m7WTEHMHJl4L
         aQ6hkcolm5/PHaOxMoSjG4mxuQrnMTQst7u0Og9K4U+wla/yNXtj1yp7wenENN2iw2
         8wNbuwtHfY61EhgwZQrwy+WMo738R+LKZmTCk90JRGyyHnJvUOwb8I4fX8QuKYpxxL
         0k1Ao8kIj4OxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5DB6F403F2; Fri, 23 Jul 2021 15:27:57 -0300 (-03)
Date:   Fri, 23 Jul 2021 15:27:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
Message-ID: <YPsKLa0Qe5/as4Jh@kernel.org>
References: <20210715013343.2286699-1-irogers@google.com>
 <20210715013343.2286699-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210715013343.2286699-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
> Enabled to ensure that info pages build.

How did you test this? I tried installing texinfo, that is where
makeinfo belongs:

⬢[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
texinfo-6.7-10.fc34.x86_64
⬢[acme@toolbox perf]$ rpm -q texinfo
texinfo-6.7-10.fc34.x86_64
⬢[acme@toolbox perf]$

And then:

⬢[acme@toolbox perf]$ make -C tools/perf O=/tmp/build/perf install-doc
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
  INSTALL Documentation-man
make: Leaving directory '/var/home/acme/git/perf/tools/perf'
⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ find ~/share/ -name "*.info"
⬢[acme@toolbox perf]$ find ~/share/ -name "*.1"
/var/home/acme/share/man/man1/perf-annotate.1
/var/home/acme/share/man/man1/perf-archive.1
/var/home/acme/share/man/man1/perf-bench.1
/var/home/acme/share/man/man1/perf-buildid-cache.1
/var/home/acme/share/man/man1/perf-buildid-list.1
/var/home/acme/share/man/man1/perf-c2c.1
/var/home/acme/share/man/man1/perf-config.1
/var/home/acme/share/man/man1/perf-daemon.1
/var/home/acme/share/man/man1/perf-data.1
/var/home/acme/share/man/man1/perf-diff.1
/var/home/acme/share/man/man1/perf-dlfilter.1
/var/home/acme/share/man/man1/perf-evlist.1
/var/home/acme/share/man/man1/perf-ftrace.1
/var/home/acme/share/man/man1/perf-help.1
/var/home/acme/share/man/man1/perf-inject.1
/var/home/acme/share/man/man1/perf-intel-pt.1
/var/home/acme/share/man/man1/perf-iostat.1
/var/home/acme/share/man/man1/perf-kallsyms.1
/var/home/acme/share/man/man1/perf-kmem.1
/var/home/acme/share/man/man1/perf-kvm.1
/var/home/acme/share/man/man1/perf-list.1
/var/home/acme/share/man/man1/perf-lock.1
/var/home/acme/share/man/man1/perf-mem.1
/var/home/acme/share/man/man1/perf-probe.1
/var/home/acme/share/man/man1/perf-record.1
/var/home/acme/share/man/man1/perf-report.1
/var/home/acme/share/man/man1/perf-sched.1
/var/home/acme/share/man/man1/perf-script-perl.1
/var/home/acme/share/man/man1/perf-script-python.1
/var/home/acme/share/man/man1/perf-script.1
/var/home/acme/share/man/man1/perf-stat.1
/var/home/acme/share/man/man1/perf-test.1
/var/home/acme/share/man/man1/perf-timechart.1
/var/home/acme/share/man/man1/perf-top.1
/var/home/acme/share/man/man1/perf-trace.1
/var/home/acme/share/man/man1/perf-version.1
/var/home/acme/share/man/man1/perf.1
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ ls -la ~/share/info
ls: cannot access '/var/home/acme/share/info': No such file or directory

- Arnaldo
