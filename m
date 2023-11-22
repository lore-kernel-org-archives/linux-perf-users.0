Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwb5hwGK"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA0191
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 18:28:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso33109807b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 18:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700620094; x=1701224894; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9IER+tn3y73SnSAMuBhvXywbHOoikax61O9o+LNCM00=;
        b=bwb5hwGK+G0RyFqP8rWxyp5SQdIk0YoDhCFusnvQVU5bbhUZWqSQt2aNeZlleEwxbY
         E5NVuJ6uRvaTgrJYsXpuXv9LPOXVXEKbyOxJGAH5UZhnPedBmY8Ui7FinCopZkp0/QT9
         ZT0fGrQDamJcqiLg61QUB4bOw/ujQ43KOhvEAmRBtmKlH4ZUe0ASlJULnPFPSasFSKbY
         J9SwGzs/pYCa4pSDxV8438XBvdsBhmJI8Al8VC5H+68w4x12bIjbj4VxwdoKOhCj2nKX
         5bt+0b9r/TrwcTHcmIkY9Drs3x4J4bj7rCJeRGbODdysOmahVAyvPNaQ4dMTGIVwxZP4
         Y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700620094; x=1701224894;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IER+tn3y73SnSAMuBhvXywbHOoikax61O9o+LNCM00=;
        b=WK6liZZTd+cnG5f2WYvwvykKrRG+weP42xVqmQIo+e5Pak3OJHd7Z8jO8kihB2c2+U
         gd7yL73UQLSQyhk3w4EIgRH7Vm82lZqO+r2/ePkXZ91idejbU8k8VQMibwHVdiHtSeiv
         WET0jJ0j2k/8nK7feinjK+v+dE89oPlSffPJju2QSzu4mq3ctAdaQawEK+k3aT2ReCa0
         4VMTwcXbvspzDec8XTHTBtroj6XcYJRiSQtFcVvZCT4o6wtkFCjaLVqyLodjFahaP3LA
         rARgqhfm7nwJI7dK06rO68bFxe5VD7J6OoaDGQ6A65cocyi8zHR0VibTvccJy6YrCal+
         ndrA==
X-Gm-Message-State: AOJu0Yxck9Sa0GdByYvQOLiyJXHyYZSKYDr4xZ3lU56QDSVzGD8UKqkt
	uNTTS2XDhdOwpOXUXr4xLNAkD0UvukvD
X-Google-Smtp-Source: AGHT+IEMWMjJj09uw4Nlu7T4ianRv1mF94E9duB9ORIltrxhzkgw2vuhjiSzHYsw5cFB71Lm1H+2io6r+y6B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c36:a8cf:912c:9142])
 (user=irogers job=sendgmr) by 2002:a81:4851:0:b0:5cb:f2cf:1572 with SMTP id
 v78-20020a814851000000b005cbf2cf1572mr22851ywa.1.1700620093802; Tue, 21 Nov
 2023 18:28:13 -0800 (PST)
Date: Tue, 21 Nov 2023 18:28:05 -0800
Message-Id: <20231122022805.511839-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The necessary files for generating sysreg-defs.h need adding to the
perf tool MANIFEST that lists the files for packaging the perf tool
source code. Fix for the following:

```
$ make perf-tar-src-pkg
$ tar xvf perf-6.7.0-rc2.tar
$ cd perf-6.7.0-rc2
$ make -C tools/perf
...
  PERF_VERSION = 6.7.rc2.gc2d5304e6c64
make[3]: *** No rule to make target 'perf-6.7.0-rc2/arch/arm64/tools/gen-sysreg.awk', needed by 'perf-6.7.0-rc2/tools/arch/arm64/include/generated/asm/sysreg-defs.h'.  Stop.
make[2]: *** [Makefile.perf:456: arm64-sysreg-defs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory 'perf-6.7.0-rc2/tools/perf'
...
```

Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
---
Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/MANIFEST | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 1da7f4b91b4f..dc42de1785ce 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,3 +1,5 @@
+arch/arm64/tools/gen-sysreg.awk
+arch/arm64/tools/sysreg
 tools/perf
 tools/arch
 tools/scripts
-- 
2.43.0.rc1.413.gea7ed67945-goog

