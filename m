Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479813;
	b=kRfVMndh+/BEqXatSSNOa1v/ImPeRHYa28QxF7OYkr5fM96I0O4DU0Xa/pgqbYKmKiNs
	 sMBjLxcIPS8kU0FSGGNKTtknpphSI9oM/WkaONFfbVSfu5EKhX8R8xyN4/XgofdQOJ5fG
	 Ys0yr/zdhjFB7x05C0vJVzgOK1rNIwhOM+/60oMGKeTVckUWAMkBAKYfTwGNj/uqj1K2N
	 MqRRFuVlHXsY4SjTOOJHQ/zwCHQmnfyRyaDRTyyHG9SEGJEgL2pFel0iNQlVrBS+7ThJJ
	 OFeDtii1k986yj82oz8reIpM4MSTVpEtU1AwATsEYNm5KSOmQ4mtm/Mc2m5/pmOU5Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i2EywLV34ZfIG+FMDzUgE+BJEY60aMQPmD/XO7mY9rY=;
	b=JU9MP3PjxMwsG0Xr73lsTLD8mW7FGr8H6W4tSshRxEij6SkQgG4bh2gye5X+WCnXlwMJ
	 EK4XWjzJuzSMdvkAJclSRr1X0jvyrEUS1ePvMVJlrXk2uyBwL9y0P2ygjYFDM/fi/b9Zk
	 v/d1BKH/e9wslOF0E0QmB3TgiT7q2+t3SoD3V6wFEo+JGvRcR9H+KphuZxW6gdELKs0LQ
	 QTo/Javf9418NKe5cRBsMAKtS1gqzH+90YITp2PhqxACCOEGkVIK1nXXawOyufDOSJJfl
	 9mC48beaVfIK5xDuhxQgbI3DvDW9Ks8q9fo0D4IA4yypK6snjKuni8QfaDRgFPUWpuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwn8carH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC9606A33E;
	Tue, 24 Nov 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwn8carH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EB81F000C4;
	Tue, 24 Nov 2026 00:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479813;
	bh=i2EywLV34ZfIG+FMDzUgE+BJEY60aMQPmD/XO7mY9rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwn8carHyHZ7nGIA0Q/HSFDvGYsWE/B2ekwob7+3TfiI4aMAwRxiA66XZRRzv/8Nf
	 Pb+gQsfoQdjhe99ZCi230GESBtOkmiIhVGPnZgIGWzgin56OF2gGdb/eD/jLumgGxt
	 ptnj3D5MEPws4aCS0Gvh99BzUerUe10zGaiMqp5Ivll3KCKdCVoi99VHXOMIPqfVBI
	 ERgouqbKECF4z6xvicKF5Awf6ze5YXeor37RGxSWiCRUojF+/dUvDDLtDzFmuuD/Ol
	 LxBjLoQiZzJPgGKvMs5/vXxs8LABx9BswiSDvWK5wkDOLrqF9mhFulVIkpcJYW3x0e
	 5/f6D4QzbCN2w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 17/26] KVM: x86/pmu: Ignore reserved bits on writes to GLOBAL_STATUS_CLR
Date: Tue, 24 Nov 2026 00:22:54 +0000
Message-ID: <20261124002303.1785363-18-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
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

In preparation for propagating GLOBAL_STATUS_CLR writes to hardware if
the guest's mediated PMU context is loaded, ignore reserved bits when
the guest writes AMD's GLOBAL_STATUS_CLR, as is already done for
GLOBAL_STATUS_SET, so that guest-controlled reserved bits aren't written
to hardware.

Writes to Intel's GLOBAL_OVF_CTRL, which share the code, are unaffected,
as they already #GP if any reserved bits are set.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d312f1b2f586a..81278a64be43f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -962,7 +962,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (!msr_info->host_initiated)
-			pmu->global_status &= ~data;
+			pmu->global_status &= ~(data & ~pmu->global_status_rsvd);
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
-- 
2.56.1.809.ga0b61035b5-goog

