Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F42586
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yt7n2HOT"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF73C0
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:42:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so1013005b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269334; x=1697874134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXxaobQ9K38/gK95bNuK+bvOAZXTWecB5ef3F+VH4sQ=;
        b=Yt7n2HOTqvk4ba2+v+wAwpvjzFtSq7tQJ5of/2XfnH1+EKt9UgHPjmt8sQWlt/3JDV
         ayeAbqFezE0sT6WR8A2Zp0f4tJt5a9uXp3Aby3IooeT2d/2IzG0QBHJbqD6iL3YiAbcT
         kL724o3y9siPdAli/vDa4PS9Y4vQn660lIFyEj+WhUzCwW5kwhg94j0OoAuksme2K+mY
         1ZPNenwOBiCz03sCCtucR+db3jYvJIXRk9oBEEnLtAaspL0/zW7xkxr4VM+sbL9UYf5h
         C87KpIAfPcncBJ21J3NE+ni2CeikwU64K/02WVVDUo8stZvMWKY8wMbQhsmH1zFGH5FT
         nnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269334; x=1697874134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXxaobQ9K38/gK95bNuK+bvOAZXTWecB5ef3F+VH4sQ=;
        b=WUCPiUaToYbrVKZdNRIAEQl6340Ln4Dbf3DnqeKSCQ+fUtPDKstBvScmQa8KIXzXV1
         njr32Wt6M+98QSSngqEEvJK23JEtmvme5CthbJBKE/FvUf1OVYjromfa3uJRz5dUglZU
         1je9mZfVeyljMQSUloCDmJ6Q3rB7c0+JFMmHST3Q2WLgti3EcT3HB/yayhE1o0vixH3M
         GnsIDg2kYWY79W7MPBwyxhbSD0bc8/SbVRdd14Eb0s4jFgCThBoaqHTRtY5HpIZP7FfT
         zPlN4gsFbG6OJgUZpnXu5kR9/JRWF4ZIk9FuuYWZ0NCp3PPRAWs3PkzKX94q0HdoXG0Y
         /kPg==
X-Gm-Message-State: AOJu0Yxk2FO2IoVbx/jSEWVkuT+ao4hZbTu8980+nHl+5U6mmsStgaz+
	0UzHFFcr3pRsMfvKSjekayzvpg==
X-Google-Smtp-Source: AGHT+IGcVUgx3nU+w0wcZJrjCCPKDU059QOm4igtEbkEJHWclbME3f2cxUe/LO9Opao5s93fynh/Zg==
X-Received: by 2002:a05:6a20:7291:b0:157:b453:dbb9 with SMTP id o17-20020a056a20729100b00157b453dbb9mr31350342pzk.6.1697269333671;
        Sat, 14 Oct 2023 00:42:13 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001c5b8087fe5sm4957319pls.94.2023.10.14.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:42:13 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 RESEND 0/2] perf cs-etm: Improve timestamp tracing
Date: Sat, 14 Oct 2023 15:41:57 +0800
Message-Id: <20231014074159.1667880-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series is to improve timestamp handling in per-thread mode.

The current code doesn't validate timestamp and always return success for
per-thread mode, for a sane implementation, the first patch is to allow
validation timestamp tracing in per-thread mode.

The second patch is to respect timestamp option "--timestamp" or "-T",
when users set this option, the tool will automatically enable hardware
timestamp tracing in Arm CoreSight.

This patch set is rebased on the latest perf-tools-next branch, and
tested on Arm Juno board. And added James Clark's review tags.


Leo Yan (2):
  perf cs-etm: Validate timestamp tracing in per-thread mode
  perf cs-etm: Respect timestamp option

 tools/perf/arch/arm/util/cs-etm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1

