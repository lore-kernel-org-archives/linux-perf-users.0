Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630160;
	b=RXqAwZrkeoG46xRO/V6zzloHM1opmfm5f4Ygqm1nE+hVjnCpR4f3MfJ9NxRSH21Vksjj
	 XfOVQ1KEb/pMN1BQx66pg6D945aCMzo4upmWxeNIb/3GAKhzJaol+mNIRMMYnMy7b6WxI
	 dKBqou9Avmk/w/GvEz8Lg+dLRiaKfj0xSi8HKLIj2hbKSq2HrNkCZw//AQWKtBMhGrFbY
	 UHWULDdQMliwR8cSnrjOxQYU/+V1o6CURTcH7aWWP0/YbsdwcGWZy3TZsfv3fHM+HIkFl
	 1YZGVuERIlIOhyya19I2JQZHhD3TRZ3tjtCoqTmnA0a14iRnN6Q6Xwone9lmskdqdZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cG4RLLEisLeuv1nOnGbVHMdbGJ1Wto1enwMwozM53pk=;
	b=K6kXadBRqewMzoTmgI1e2g86gHA0+108b4+xMUpBHqETFuafX6+EiAuGe3LC4/htv5KY
	 XHEzIbe0wOwKxN2FQyuhk3nfcEUV4KWKg2T3yaK0GUSMhF551lKcbo+KdCZryoAMKvApA
	 Tc5aJY5qPsYFFFg+4ylrqZqQyLMjetYbNlenocFPxMgYizLGxU+0vq9UIWCQeXjQAK+3E
	 w3d92lcq0lRCYSin4n1yd9TVYEoudAtCfGCe8//pJpOA002Ya+Lr+sMR18QnlDT8v99Wr
	 NwM3rGWKx39qwg4BLD43Ogl3IjOomYzYhrwp5BQXD3P8pyGFNwTd2nrox2NztMlTcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=opDCLUHz;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AA606A329
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 18:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A77AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=opDCLUHz
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38190551625so12059599eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 10:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795630159; x=1796234959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cG4RLLEisLeuv1nOnGbVHMdbGJ1Wto1enwMwozM53pk=;
        b=opDCLUHzaV5+Wfq9y8kHe0DAkBuHzAjldtQ2UWfWWgbNnH+T/5J5qxJiwFKZFGcd+V
         Kgj4AZQVkfJYH7SbL8sHvGF4wzQFgOUDOa+A1kZX42uocIdrMfYutsk0cTFLx0pwWlki
         YCcKQB/gn3DgfKyFORYYSC3M+Dns3rq+dmKp0fOUcZ+dzBUJ8SWCQ+E8M8Dme6HzttG8
         RTWXeLO8UAZdwcgusieB71zSiUBrFcmDDOTshUClKGGLn3yNfpqLb2tKbJWSAfF4l/II
         8eXTgh4ehM/Gdp6AgfGym/kmEtQ3EC0o1cbV+a6OjO18p/NdTetcn4NGJIKlBziQn4mV
         DwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630159; x=1796234959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cG4RLLEisLeuv1nOnGbVHMdbGJ1Wto1enwMwozM53pk=;
        b=sp0Fe0FXVoXDE02YPSkvspjzD7fvYaYFtbrFBrF9yX+c61AwGjrFuuIDE2c4BLRTKA
         CH80Hmelg/KBA72o9106xSC/t449mfed3/fP2yfYvQCpDD+dSRTSFCKRMayeww5g2HRC
         IQlGfITBlvyMZOWR4ZIfCkB2UuQV2s6C9AJqi4DU9CECNWsS7QzpZTntUpmozZqgjT3S
         5wixgOAO9ssYVrLjfN3WQ1PF16XBoDRFhKuczE9pjPllKvrGBmKfEZS4JoeBJ2eeSFuR
         bJ5tKoxlp8L3YHaqbFJAZOK4N4SsU3GMLJghYwTyoWzATQYuxOlvN19IvwTQ2Yp/8l7h
         ByjA==
X-Gm-Message-State: APuU4Z8TAx4sGTuIN5TW/EWlRsMniGCV5nkWta0af8Nm6qb2yNKGIV2f
	gAEhkzctiZLtlu7ylc6bx6u9u6IPqnv3D3J7p7HQXX1JS1uHbX+JqzG9CnEDpeBG
X-Gm-Gg: AZFdTZe8OPKlEwO7bnOIDusL1eEelmCKS+suAu25Sh+RWc7Yp1/QbUExjanHi/kcjYm
	bhZM6ENRlkUam9AHqPV5OVGSHPkkj1+7j9pqdT8wVvsV6f5AaIeIuFkhHiXO/bTgHMOXx/gkx2x
	tupEm0A2SgDra99loMrLLATMJ+KW3rJVOnKAgtO4jH1XBz3WiwLoS70f5ZFu3SnNxL+WKEOxuTX
	kURwHVkIBnw7jhLLoMxcSWG9WbTkd7PN7BAEwewcYpRLJuRyd8LILSxEaZAClcdrB+t4CT1L40/
	XN0GSeChL7fTmx6sO1E2LsYE99RaXMDVxOQbXbvO6dTnp/f9Czqf/ixllPLinG8wBvZqSTuwjfL
	fMPNtUT1bcuG/OUwCRzTznQ2kdqEhb4s2XqSwjLoe+0LsQs1N4uo/S3fVcHaV3YLQIhsgkku+36
	Ztg3WSu+wHpR9XK2YYOmrQgZmVKJlfL55vfiGpMrnZw21ZvF2CDKEpgpW9dGsSm3FadKUe4b+R8
	anunLno0+qiDO/jveJCFoLKJdio+OubOan+mSa8BAlyajS/SGcitzXkxnszcLY+4W2aiSeG8ksh
	4TR3VPTwglGEeuvawoP4
X-Received: by 2002:a05:693c:60d4:b0:37e:fac6:7ef1 with SMTP id 5a478bee46e88-38571120627mr19259410eec.39.1795630158685;
        Wed, 25 Nov 2026 10:09:18 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98983110eec.3.2026.11.25.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:09:18 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 2/2] perf build: Make check-headers.sh fail on a difference
Date: Wed, 25 Nov 2026 18:09:12 +0000
Message-ID: <20261125180912.2388197-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180912.2388197-1-takano32@gmail.com>
References: <20261125180912.2388197-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script collects the stale copies in FAILURES, prints them and exits
with the status of the last echo, so `make check-headers` succeeds on a
tree whose copies are out of sync and cannot be used as a gate.  This is
what it prints for a stale x86 cpufeatures.h:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h \
           arch/x86/include/asm/cpufeatures.h

Exit 1 when the array is not empty, so a caller can tell the two apart.

The list that fills the array has a typo: include/linux/list-sort.h does
not exist, the file is list_sort.h.  check_2() tests the source file with
-f and skips the pair silently, so that copy was never checked.  The two
files are identical today, and the pair is compared now.

Verification: with a difference in either file the script exits 1 and
names the pair; with none it exits 0 and prints nothing.  Before the
change it exited 0 in both cases.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/check-headers.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..3211e5f3dd9a 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -28,7 +28,7 @@ declare -a FILES=(
   "include/vdso/unaligned.h"
   "include/linux/gfp_types.h"
   "include/linux/hash.h"
-  "include/linux/list-sort.h"
+  "include/linux/list_sort.h"
   "include/uapi/linux/hw_breakpoint.h"
   "arch/x86/include/asm/cpufeatures.h"
   "arch/x86/include/asm/inat_types.h"
@@ -231,4 +231,5 @@ then
   do
     echo "  diff -u $i"
   done
+  exit 1
 fi
-- 
2.53.0

