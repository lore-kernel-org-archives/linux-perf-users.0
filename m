Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBC19BB9
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeGyKxnh"
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592ED3;
	Mon, 30 Oct 2023 11:59:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso2999026a12.2;
        Mon, 30 Oct 2023 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692358; x=1699297158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So3aY4FlkZVxmSDWIXnKczJGjc5FfKNoN8ebCZefWpE=;
        b=SeGyKxnhT2RdiBX9E94Sr/qPXiW1PStbMxhmwzj75SoWMWDz6t+fD83i2rKP9KJvWW
         TOoufsrJHj5eT0P/9HPU9UMD3ckQu3aODiRHSEWEBwSAxXfwXodU2bJ2jLGLjAH4mly6
         mmmhjDgLmzi5bdDblJR5J96N/AndCwwbrLb2qSfZjIUFcOiacDNgSb7o2Fr01Io/dOqV
         Xuje4bUfr+bsLWLYPCOd6tvHLvLcnkXPev5U+Q4U6h+M1/Z/9mlXeFUYYXghFxrvWitV
         /IvDx4Wrdw/dwJ+rNAmWepHjF/QUClpeWT5NgciYnd1v+IAZN4CJyew4w4V+H33RjVeg
         gOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692358; x=1699297158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So3aY4FlkZVxmSDWIXnKczJGjc5FfKNoN8ebCZefWpE=;
        b=demMAl1rvjjSy6v3Ck7xblcUmfIj6aP8bhwEgehhfZgvhHNlvjgR81rhV7+OYKhPjJ
         PyJGjlGKOWUlG/3ctpdwVSq/G9meE+fI0SkT1xPrAH0FdN0KoUD6l68H3cv+LFpybZYx
         BOl1JJtXvllI0CrbwwI8fAxuNwd0OnarXKaza4qs+/8Od8cvoeMPkBX3chHKnJejxjav
         ew72/WYl6OFy5pwIMsP9ZNwlEc16uFPi8+y+TJCX5j1HWpCyDRCscMIkgmT6lVjsQ9oe
         3YyT77lyCOgCrgiT8MCy9VLvA9Hle/dH+uf5XWYi3A7mJ5Y/YeGz1dPOcmmt1PBU0PEC
         tbFg==
X-Gm-Message-State: AOJu0YyZLKzkEL6gNHH+52KYWKqWHziHt3XBlV1KbJcPjjBbT+Ny0R7l
	B2iBUdAvbzfCYBfOG15vnSnRnX6FYdU=
X-Google-Smtp-Source: AGHT+IGEXQ7yeY2xtReUtGwtr4ha3gDVwgt6/WfnSV/XZ6boqxoii5zpMx/44M3Vd6iPNRQa76PrOw==
X-Received: by 2002:a05:6a21:66c7:b0:17f:cf8e:2415 with SMTP id ze7-20020a056a2166c700b0017fcf8e2415mr6073607pzb.54.1698692358189;
        Mon, 30 Oct 2023 11:59:18 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com,
	tianruidong@linux.alibaba.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
Date: Mon, 30 Oct 2023 11:59:05 -0700
Message-ID: <169869215960.2773399.671365445660310243.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231023131550.487760-1-james.clark@arm.com>
References: <20231023131550.487760-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Oct 2023 14:15:49 +0100, James Clark wrote:
> There are two reasons to do this, firstly there is a shellcheck warning
> in cs_etm_dev_name(), which can be completely deleted. And secondly the
> current iteration method doesn't support systems with both ETE and ETM
> because it picks one or the other. There isn't a known system with this
> configuration, but it could happen in the future.
> 
> Iterating over all the sources for each CPU can be done by going through
> /sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
> to the Coresight device in /sys/bus/coresight/devices. This will work
> whether the device is ETE, ETM or any future name, and is much simpler
> and doesn't require any hard coded version numbers
> 
> [...]

Applied to perf-tools-next, thanks!
