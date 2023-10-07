Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE571845
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PCu1jWKE"
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 12:03:33 PDT
Received: from st43p00im-ztbu10073701.me.com (st43p00im-ztbu10073701.me.com [17.58.63.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A193
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1696704938;
	bh=F9EDgySKAqzaEyTQfAQOv+X3fKaJ8b5RqfEk4kbUM1Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=PCu1jWKEhCfwaBm0YKPOsV6jnpqj+yTAgmT2PtEaegT2iorj1/FJVLTBJ1KPlQ+8c
	 j7joOpecpMuh1ab918HDXJ6F+e80B6gAgXJu6EZFftuk4fEp6TAJwDEZ/hGuDMJGsZ
	 vjw9EN0RywCnogt7i0FKKLIcO/sBzaETDT7g8eorz3vhRcjQ973Hj+laAo0LFVlKUX
	 DMLvdA0AWBBWIvp0DC9ZQZ4/L4SEzDxCcKKocEOPxuUJf3h0p8oQCFOLZ3LjR+ORIh
	 2KvOyz6qi+jA7gz1ImDKT/qxHCmUxT4cZKhfyfo1qKY7oBbV6k32j1LnAaG3Mu4lv8
	 XGotq01PwBwbA==
Received: from mainframe (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id A49F01C018E;
	Sat,  7 Oct 2023 18:55:21 +0000 (UTC)
Date: Sat, 7 Oct 2023 20:55:19 +0200
From: Lucy Mielke <lucymielke@icloud.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
Message-ID: <ZSGpl_hT23B6ix0M@mainframe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This fixes a compiler warning when compiling an allyesconfig with W=1:
warning: variable ´high´ set but not used [-Wunused-but-set-variable]

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 arch/x86/events/intel/p4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 35936188db01..69aaf7c0f340 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1366,7 +1366,7 @@ static __initconst const struct x86_pmu p4_pmu = {
 
 __init int p4_pmu_init(void)
 {
-	unsigned int low, high;
+	unsigned int low, __maybe_unused high;
 	int i, reg;
 
 	/* If we get stripped -- indexing fails */
-- 
2.42.0

