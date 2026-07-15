Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEC4949EC;
	Wed, 15 Jul 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140810; cv=none; b=iiF0VnRlCUeiWdP7TB4G4mMyL2+Eahlnhw7dA2MqHKe05K2uFxdmcGDPCQj/Ng326vyZCjj6+x2n3r11Ca9NrD8ZIoU22M1CvSo6RqKIar5/PHjX21cJyqiGp/CPXGcoHAHKH4M0PAgGKgcm3F//CRAKIPWX8gL7scvc4sirThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140810; c=relaxed/simple;
	bh=OEhdMGRrWrAZX6zXEyVuFKcovyYbS7wBk3Et2JM2g1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=liZrD3fQX1/uLDQVtQ/Av6z2De/I/jdGIMcaKMtpYgkYNoQ4VhYqtmZW40tfNBg8ORG7pPhZzsuq9iKvmHer0PzW240lytdWwsoKpojvsZZBgBKCKkynuRTjYcs4NliLg3ZUqOIJk6NLfXAQfjx8S8C3Nkk7NDMt9/RZ/NQTqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St8n03ee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St8n03ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAE21F00A3E;
	Wed, 15 Jul 2026 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140798;
	bh=mtttv+/LVF2WmnUJQxtrUPh/1eD27s/pfFZBpOenwgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=St8n03eedWLKmHBD06eGbeBR6FHnuwMzy3HoQlps6NnEECPFEHc+BrycEK0bJUTCM
	 B096Xl3q8wFR3asg8jSij3AsSY1iR1fGvWxaacMUhbaLPUnIW+Fca8o0CWDPUTfQmg
	 9vnIg3KhUxvND7X9XYTT9j5ZJVF9Tcwui/YUD+U1V++gwp4XtkXrORSlB8RieKr1FU
	 oCsDm6qiluqQ/8VFKG5Lhq98jZGKePXVFdJ7gfIeVuyqAbXJk7EfIG/epEcI8zq/J6
	 ARnqvDsF1S6vNYNza4tQiU5XAo4VR9Vj652VBi3cW/9zZkoYmm7vgnj7CaY3vGNY79
	 LKlWmBcDCe5pg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
In-Reply-To: <20260708053226.3776183-1-dapeng1.mi@linux.intel.com>
References: <20260708053226.3776183-1-dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH] perf jevents: Add Intel OMR MSR mappings
Message-Id: <178414079786.2318976.1720252632382617060.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 11:39:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 13:32:26 +0800, Dapeng Mi wrote:
> New OMR MSRs are introduced for OMR events on DMR and NVL. Perf continues
> to reuse the existing offcore_rsp attribute to encode the MSR value,
> similar to existing OCR event handling.
> 
> Add the corresponding OMR MSR mappings in lookup_msr() so jevents can
> translate these events and generate the correct offcore_rsp attribute.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


