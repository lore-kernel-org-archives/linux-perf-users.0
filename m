Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793300771;
	b=es/mPKRSaxa8IVMKVsvjU/TY4vSRDHKR9x8lSkuzISlSSbwYvB4Y9WthJMn2zJROeyxr
	 fqcp+20dPwngEww/mkvpP4+lc4J0Fpn/6KXSO0epBAMzlLh4ylAQ41xN2EQjkSZVhfNOY
	 wKhtIX8zjTpSmQ0kBI1JXh55o71t7R4sMQe3zAJmr/IOy8VCX4aif3zai4cEpyVYkeXh5
	 ZQ3x61uOHSjS8W6SdDoVSbSnMJ8E7su1JpYkCZ6/01N3u6hU9WSrGv5x4YyhGdXTFBloV
	 UU4q/IzZzRlQvPMmvyDPdf4Jzysw2la2znEaN3Iuvb5ISx25g/UI9nl6DVGDMhpY6LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300771;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=bBTbamxbWpUfuRTsty77JvkRbw0GaSMSTgPsfguDsxk=;
	b=U0Q8MPmIRApuqQsaSpHIyPbbvqZS7yjd0MvIR6vFzhP90v4Cci8GrWFxS1fCsaRNmyfM
	 CuW+NJj6KV8b4VJEt6SOQ0MYY2wZyaWhe1aXij7hjP0Vuej39k7j5vgemiKe0I6XoUGjw
	 0zdI9FuhtMc7TomnUwRcQ0ccU1cnbZW0GtbPNT2vDVUsC10AvrNRTDqcr1FAD6tTMWJhv
	 VpcH74z29I+OCoV3HNw4hcTFhNRprukkXKj04HOaCZciJAT5SnWvl8/2sH5qKgX79Cjb8
	 u1gTST1b3o+q7mf7LRc20IKLUuhuSHWLkVestCZPXkRJkmaH7cyJQEcWT5BeEb3lwRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQan5TN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33013606A31F;
	Thu, 29 Oct 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQan5TN4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793300770;
	b=MYp6jrllrEgymK0XGC2oJJmf1PAIBNJXa+0rD9GLREyPEvt/suogksdsUyaF5B1OmqJP
	 E7WOSs+GzmAN9tneZC3Aa6lWgh0AVmPBiqvtm2d+NHA/4K/SXC0QSodh2cDjQYON7bUmB
	 l8LNuf4uLATfYIkhzJGWYu7D9I/vPr8wpzL3AbR+2vM+p38WNIcPaHqvt8JMc0bxdef+O
	 6yqEU0L7SS0hAvjwBPch95nGJmto6FOfy7sr0yWiutYVUxfK/vRh3+QA2NFdrgHK8pNQL
	 57AqyIZJ9n9XenRw2dCj16flEfI2tpOdiWTtYx3LmJTllYU1I0M9zH0U84WN4xY3MQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793300770;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bBTbamxbWpUfuRTsty77JvkRbw0GaSMSTgPsfguDsxk=;
	b=ViQOhNup+WMl2x6JTjkH67tHzjgSE8bef+pqrTqGsF+D1IvBM6G69u47wm9r6QujmqJY
	 FQSVPXITeIcI0ezQC8m3JzZ553xFEdspm+HM7ACukxDSCHV2mMFfFU76Sn8SG0iUR1/Mt
	 igY27aYCZaNo963fYOLV1nK0anOENiSxcCIOBAoUNQIURdLw+3GpPiuESMwr3iwKqX3g8
	 xF3fXAbtfe1yNHcDk1gOnmlkBUgPn1LFrUHcKjoDatuNuFPwhM6Ru9hGNwwevq9CM532c
	 AVy/GIY928gxaZprKZ/i3DtPyn7pIpXuRdgleFs7vtdxuvMtdoZule8n13TajdtUyJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 509331F01816;
	Thu, 29 Oct 2026 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300770;
	bh=bBTbamxbWpUfuRTsty77JvkRbw0GaSMSTgPsfguDsxk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hQan5TN4T1uUWc9oz/ab/vCcrnnpwxtLy9VGRpjlvO4Ph36vUXNDUSky7ac2MKpZ2
	 yq4Ai8cJE6QLUMj29x6aT1trXvY8H90leX5Sw9WGQSy4lAIox+0+aXJ+HYyjnJvszW
	 S5nIREEC7rZJ2gwHNI4YWVgsSITMjS0Tklh0wSVF3R3WS2OwAlX9YE6bVc/Zp6uSXb
	 wml3rVj1t9QYs6XiJ4xXcmB07uEMt7ygUF+2IwdVYXiA92GO+ejQ/RMWE4UHFwfo2A
	 N8eDBINuZQ0KCuicEId7Y/NnhHBFN6TwG5x5mEL7vtF4F1TGUfztZ69qJv/owskxIw
	 55UOSMibQmE1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C52574597A;
	Thu, 29 Oct 2026 19:06:09 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Subject: [PATCH 0/2] perf jevents: Add IOMMU PTW & device entry metrics
Date: Thu, 29 Oct 2026 19:05:49 +0000
Message-Id: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBvwJ0S6SrSIHGsgVFQiiO6et
 PwW7z1QqTBVmMQDhS6unGKHGgRsxxp3QvbdoKW2SmqHmUrAltJZMdLd0AWv/GiMUXaFXuVCge/
 /OC/v+wF/0kB8YQAAAA==
X-Change-ID: 20261028-perf-tools-next-8fd1d433316a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Chaney <bchaney@akamai.com>, Matt Pelland <mpelland@akamai.com>, 
 Jacob Lefkowitz <jlefkowi@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=9W/7zSoftzSW5mCuATcSpLhTLtAaT6I/Mh4CFqig25w=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq45kgZpFbvA6GVbT+n9Qw6F1Ls6vUDYXekCgN9
 hINXOkM2XeJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauOZIAAKCRDSyn4M48E0
 tSzXEAC4mq191t8r5p0TM73BaVqAZBdeswKU93lCq78nfvzsw7XwUeMm2HpZiHAS/0rK9sOHDXx
 vfBbuKWCy+QSZFtkc8qm0meHnjb95LO0dD4G3E1qogF16hJ9suDLyD9h+tw4nnMazslmSpM/5X2
 trjfp9yEG8Is75WjlRDXn48E1HscT29gmp//ziK2+Gzx90IBOTiyMmIkNIZpaf5JcoMUmt1Jar3
 ZK1rHwODaaukrGFHUzw3Yqw1f9xGUGZqq9G7FhHPtL53lx12yJx+VOZigDRKu8mz6g8+tN82ysY
 lsIIYaK7EFTLaRD8+ATRdK4P1HSeFmVuIyOpXVW37KVkZIYWKzpCUo3pWXdmkc5DDiCyuhMUVW4
 fk6wPfd0vEgisRx0wxSY7vF6nxbn57aNqeXZRaiW6E8Qn2F4nvEj0Of+e16oIlunbGls9dbqDJH
 ge3u3rlG7XMvfaS1RZLlnwLYgeiUQT5nc7wxB1P3jZsSbwR/EfVuVZAXhxEmF2OaqC+2Vs2u+M9
 k7VyWnoyj6KU0HhNTt0VUJz8AFG+FXXfGGuWeeE9aE7CML6hfUJncOXb8MlAQhE0+7+1ND9LSNf
 TV6RfXSU5oDySHBuxKtg9K7sBzmAH8B+okx/GWV9Yl03q3d6HXwHlSpfmdf29YRQUy0rLjZtD4A
 PiLqHBVfBvMJKHw==
X-Developer-Key: i=jlefkowi@akamai.com; a=openpgp;
 fpr=0A16656922183B84523BB1C4D2CA7E0CE3C134B5
X-Endpoint-Received: by B4 Relay for jlefkowi@akamai.com/default with
 auth_id=1357
X-Original-From: Jacob Lefkowitz <jlefkowi@akamai.com>
Reply-To: jlefkowi@akamai.com

Adds AMD specific metrics for the IOMMU with respect to page table
walks and device table entires. The metrics cover ratios, rates, and
percentages with respect to any event which might be triggered during
a page table walk or device table entry lookup.

The metrics target Zen 2+ processors and use the standard amd_iommu
PMU events. They have been tested with a benchmark C program that
purposefully thrashed the TLB as well as with 'sleep 10'; both of
which work as expected.

The changes are split into two patches:
1. perf jevents: add iommu page table walk metrics
2. perf jevents: add amd specific device table entry metrics

The specific metris added are:
- lpm_iommu_dte_miss_rate
- lpm_iommu_dte_lookups
- lpm_iommu_ptw_reads_per_tlb_miss
- lpm_iommu_ptw_nested_read_ratio
- lpm_iommu_ptw_guest_read_ratio
- lpm_iommu_trans_per_sec

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
Jacob Lefkowitz (2):
      perf jevents: add iommu page table walk metrics
      perf jevents: add amd specific device table entry metrics

 tools/perf/pmu-events/amd_metrics.py | 81 +++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)
---
base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
change-id: 20261028-perf-tools-next-8fd1d433316a

Best regards,
-- 
Jacob Lefkowitz <jlefkowi@akamai.com>


