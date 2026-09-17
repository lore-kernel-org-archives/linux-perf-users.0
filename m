Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B93AB273
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662338; cv=none; b=D5SYw0rEZvtxf7sCNMcqlgN9vMihrfPQfn9KeRFP+Y4twE9HUTwI94a2AfvlCdE1BVi0gsQgh/4EqMYcb1KZ2CBhvqhVG7/HqOTgVgBPPbrOMM3HVH9lvAJ9uGuObuETZuecBZo9goNnwaeHfBKaSVEMAMSFGFRWdD/Y2zBv4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662338; c=relaxed/simple;
	bh=rtvmHSWXSmxkuH2d1GtpV9D/iH6hOVoLVjJ/X0LT4VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaCDiQIznXIoHGr+bJzQ1GDb7Y8UBblgY9XJE+GPgSrGcn88Hux/r9e8zJ4u0obsPij6aDYz6jLciU2Gxb3uglw4+hhBon7T3QfgLq5W/oDlbjnsTd0N1IX/rgo4ZhGlX++VHPOi47CDMF0mfw7lTjROkySHjFtP4NYPWOeBODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=rc2gdHiX; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="rc2gdHiX"
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so353861a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789662335; x=1790267135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cI+xjeNHVNst3t+SGlRsF85lt+goiabsbiUNU03nAKw=;
        b=rc2gdHiXG4kPrPnZgypirmqXT1nL4csf38j8bCQRkSOXcFYvWHfcmvpsfwvpE0TvAu
         eSiyLspLJKF8dPj1SLT+SPQHqqUmRYthPb5aVVo3bCr3PSR4foQbbCuCdzryl3AhDluW
         uDziRHpEWKlm3yIGJfHd4YvA4fMjvk8rSJnNe68lUxo8fNQBhVeMet0vD83DxU1dPNMF
         tfX2wDujjO5CDwd5uEH5aq3BklBmPh1v+c0ormFfRhN65hIDjbkiLPZMnxt1rOpsPW0R
         DRNUNL7buAGH+XTD/nO88Jvk61QwIa+TFTvgcjbBRkOWVs+V8veoNLr3LodiV97m8O2F
         harA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662335; x=1790267135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cI+xjeNHVNst3t+SGlRsF85lt+goiabsbiUNU03nAKw=;
        b=W6FlGoxJJCBr1+2fNngfpenAVNy7gbYkLS4uPgeTWOBwzSnAcWvG1nJZKeRRzNqCny
         wcdxy8BD4Kawzx9Ia7ZPqa6dNBOLwqPZ+tc0JpPrgc11riStcD8RpjpdPxAUquxoWT5M
         08kW6mSV9W+wxeQc3XFFXj9rmdoHQc6NyftI9CiCIm0a7y4Ax2Srcs2zFxZ/cKWwCRi9
         /UBUrGIffYMneiHYLXd3KDrj0NsWsjScDRy8j5ntsV3sUeiYabVMmwJLTr4TbwhUwwc+
         m70XvCPZQO7aIk8D/roeQF/gX/lN4XMILEc3QvgvO23jRMF6Satry4NuAv8DypjaT4Vk
         7qkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuRcXF5EskUDny96IO4qhe2dHEDZiF7vJ2a8PxV5w4zdIxQvO6CPkEjjEEZ9WNkro15zcqYe9m/wUqxfCyGhVH@vger.kernel.org
X-Gm-Message-State: AFuF++mlf89BbcwnxhrUEgkqE/vUJQ64MuXSXmCx/rDRJOnQXxQROBiO
	Jkvme8Nyadnqdo7K63WdYwZzYyT2E4VK/A9/rFk7QtyRMofM+rz+Tr4DGbkV1xlp1UujNry07Qs
	TM+stPHsprdwWspKY4QKM/OmL2syztCdXtnpS
X-Gm-Gg: AYBFou11E+cuyEY4ttVW/uUi38/1J+omua9RwGu6GzLYxwCgFRJCYh83XgHhOXtEFtk
	GnnSkxCGnQd1wo7EKhIdMaSiX0KakB7TuJUx8r5hEC3D9obBOBjDXAXQkfKoT+QlXsFAlRA/qEu
	XaYariUu89G7mM9/lQthgVZZ9tNme7ipSALlH1T/qEt/GfcDIXNrVKVDUdm8xQ4gOr/RFOPyEk7
	suQxKmWIeATEvMXQH/ysG4VdWctv4nsLKK0ixgIAzLe2iS2lipBoFlp7tEdnDe/B8oYSsqypn+r
	RIFtAuXbqJ0Xumoj1HOvTxPhL6JlHnnFb6yOnbkrcxqPzGpHTM4O/GWlfzg1in4rzaD3KhxoTML
	vKM5+N6aBgOZ3KUtt3JjXtu5qQpDO8iMSVmzJqXU=
X-Received: by 2002:a05:6402:24d4:b0:6a7:ee54:f897 with SMTP id 4fb4d7f45d1cf-6aa2244349emr4232275a12.27.1789662334673;
        Thu, 17 Sep 2026 09:25:34 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6aa1cf65559sm2670116a12.0.2026.09.17.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:25:34 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 1A53034014B;
	Thu, 17 Sep 2026 09:25:33 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Harry Yoo <harry@kernel.org>
Cc: linux-mm@kvack.org,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [SLUB] nfs_page cmpxchg_double_fail and perf lock perturbation on dual-socket NFS/RDMA
Date: Thu, 17 Sep 2026 16:25:33 +0000
Message-Id: <20260917162533.600472-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aqvy8NqRRRmUlxjR@thinkstation>
References: <aqvy8NqRRRmUlxjR@thinkstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It reproduces with slab_nomerge.

I booted the same kernel with:

    $ cat /proc/cmdline
    ... slab_nomerge ...

Uninstrumented throughput remains in the high-45 to low-46 GB/s
range, as before. During perf lock it was around 30 GB/s in these
runs, versus roughly 25 GB/s previously.

The dominant lock measurements are essentially unchanged:

                         default             slab_nomerge
    unpinned/node0
      contentions        4,782,839             4,858,759
      total wait          14.39 min             14.26 min
      average wait       180.47 us             176.13 us

    node0/node0
      contentions        4,582,012             4,686,729
      total wait          14.13 min             14.34 min
      average wait       185.05 us             183.53 us

    unpinned/balanced
      contentions        4,572,196             4,544,677
      total wait          12.81 min             12.56 min
      average wait       168.14 us             165.84 us

The uninstrumented cmpxchg_double_fail deltas were:

                         default     slab_nomerge
    unpinned/node0          7,471          8,892
    node0/node0               713            457
    unpinned/balanced       1,503          1,504

The CPU-utilization change while perf lock is active also remains.
System-wide %idle for uninstrumented/instrumented windows was:

                           default                  slab_nomerge
                       uninstr.   instr.         uninstr.   instr.
    unpinned/node0      31.46%    3.60%           23.02%    2.15%
    node0/node0         84.26%   12.07%           84.62%   11.85%
    unpinned/balanced   66.86%   14.83%           66.58%   14.78%

Thanks,
Tim
