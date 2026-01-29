Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8136CE1C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729896; cv=none; b=lQU6fnhxj95DnGNyEGVp1K3vcLD2bm6tFV4oOzKF79hzP0EPYiBBd+G/u4h6CBGR9brHGbKw7XAGBYSi6fUUqmAcmqD2a8KC5nIPBp5e5q5u+hszpmwz3Ih8MbS08+dDfNWj0jfazN+L8N3giyWjOLnyHP8X5oZv5LB59AhLzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729896; c=relaxed/simple;
	bh=+Ao85fypcu2LNijyP/Yd5fo6qd6PkBX5yK78fvuZH0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lerq63WukaFgyuDNsv7/nGJzDQ0aoy+ZDfhP0pczETpyGv7czYyo9QKUF1WCMCCcIyonnEYKe6j2ai5/D4T+OdegF41bR2vg8FsOWZzP4vocPnnwRSxlROIgvPN2XbsbfJCVIZxPMclT1Q9fA4MkmZpGQzflrgcPPUdlKk59AEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIQU6XAR; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIQU6XAR"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5059656723eso43317621cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769729894; x=1770334694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1eDEoFXt8XkhH54WsqjXw1OZHZdHjK/gtE/fEZN/Ec=;
        b=fIQU6XARuE50fjACQBrLk9PRfKcR6hD2qieOl8bqXf9N9ldElOYnd+jI07hN3GjN3X
         oSFnqHjV3axGkD1eL6cjcSvSxctSdvBy9y/1Ub9c+bMaWEHVQcu0ZO8wc8bXfwNuKNEj
         vTyKWf9RusUP4kXirh4K+kjj73ZOpEXJa4jI6EOCMJTXN5tGxLTo1YUgaArNkgHPslwc
         XDo7cmw13ZIhyRI2XGwYiMfirTHU3XLJFnImFBGQiLs+ivBbKZC2MEUBkG5uWWQ5+TXt
         Y5JFrfHip6pmJpUEjugniTRMtntRvSvfdNE/7lPqNRIaj8WQYE9mDz5AszAajGh8BtNE
         BSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729894; x=1770334694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1eDEoFXt8XkhH54WsqjXw1OZHZdHjK/gtE/fEZN/Ec=;
        b=BxfNiz4UwtHZ/h6N23Oj0m14KtiTgxQfLPyx7i1TyYFcTuiTERCy1/1jtjifIdr5ZD
         2EIptRj8vq6fRG7JsrMA79DI7KHYAoVzamUsWaJOmUKjAztGB8cuLWRLjFs8CXIyJiby
         zRWthcx0FoyxZW/iAs/0iIgdqX5pdFiSA3R5EDxyhAfUwaPZpYOAk84hAT+uA4YvioNf
         KnY5yovo5YCFI2dDvDaZ50hKyVgs4unHVsoLX3RBZSZSQYys8e2li7gwC8r1yufeg+4a
         um6Iw5G179/ywh0tC/YBKt/Xr33HJAVRTaOiw4itTgXddk+RjXxOuPYHdtohvp58SxFj
         xTTg==
X-Forwarded-Encrypted: i=1; AJvYcCUEO/bwhIfkVWv7j99VMeiWPWYxG3lm8mfocsyp2NpCy41HEmtjpO5Jf5hj5mYIuanM71nu8d55BdJ9i2s8+gC9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YRo3DJ+rjtxos9ExhKQTyEfP1CSq+DpCG/TQz8stAnmHZU8O
	rdPxtVQGsW5tvQnp06RTtGbVTF+FsIKb9pq+BUPzrNmrzXTcLQa7KlQSpXVIH23XsLHIV6uxkg/
	SBxIxwiM6Kqqm4Q==
X-Received: from plcp2.prod.google.com ([2002:a17:902:e342:b0:2a5:9a63:12d0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f552:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2a8d99469cbmr8037505ad.52.1769729341586;
 Thu, 29 Jan 2026 15:29:01 -0800 (PST)
Date: Thu, 29 Jan 2026 15:28:06 -0800
In-Reply-To: <20260129232835.3710773-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129232835.3710773-2-jmattson@google.com>
Subject: [PATCH v2 1/5] KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
From: Jim Mattson <jmattson@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: mizhang@google.com, yosryahmed@google.com, sandipan.das@amd.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the computation of eventsel_hw from amd_pmu_set_msr() into a
separate helper function, amd_pmu_set_eventsel_hw().

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb072..d9ca633f9f49 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -147,6 +147,12 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
+{
+	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
+			   AMD64_EVENTSEL_GUESTONLY;
+}
+
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -166,8 +172,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
-					   AMD64_EVENTSEL_GUESTONLY;
+			amd_pmu_set_eventsel_hw(pmc);
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.53.0.rc1.225.gd81095ad13-goog

