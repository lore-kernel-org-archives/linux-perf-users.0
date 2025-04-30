Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C62DC782;
	Wed, 30 Apr 2025 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975636; cv=none; b=pu7SFnEQYd14XJFAdUSxarLtT56RSFwcIQl9LpZqBqNhR66mfkUDqCVjKqEsecs4JsZIS82YkSDjHoWd1lr6X4jWH1awMwfRI4/CPZPZ1rXuJ9g3Ur10xou9NwS/myZ0TgA5B4GEWI6X8R2IxwtJ2+s0mysJhWL2IzV7rVGfaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975636; c=relaxed/simple;
	bh=uDFgTBxxrjAiTdB762RD/JEcEdFUMtvx0lbzh//GqVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUK7eycrcExHgScamhkMH9kVRy21+wK13VRuUJd2Ha8KxkE2Jy0M6ZUcH5xZiRjlaEjS6A8XixoOYxssdXRIAF+Zey/3jO1ExCNJTYmnrgBbxfmbIJhypOGGcpSKVAVv0Nb7Y9Pt9u+YvU6Rablyy8oE6Sb6m3lLKYykqM/A4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+h6PquG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+h6PquG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF2EC4CEE3;
	Wed, 30 Apr 2025 01:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745975636;
	bh=uDFgTBxxrjAiTdB762RD/JEcEdFUMtvx0lbzh//GqVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+h6PquG3eFY5ZhOGfQfRS7KEJsRPgZTthi8Ju3c5HYUUF+GdNba+rAln1Zk/+JdE
	 OrPIDNyr8SHocWhFIC302cl1u5aYmQdAiZarEU18fDUn/bOpqNZwgp9FoSpJs1K3rA
	 Ec23UUCPAjgjlxMlXi3sM+6xoy0oALdKNtm/SugxuwYEHWCCUeacPEi2qBI8/xt4gE
	 TVsESWUy23yCX+KM0BABNYBh3mYvxr9D0tb1yXyWIBRLg+xOQEEGEztVkIgxiwH6vZ
	 EJ6a1EaiFrhSB97GeWzJvLq268KYDd6S/TxT0UpWX12MgABkTMVN4s5aDd+nD6yGbq
	 VXhYTA6kz9YOQ==
Date: Tue, 29 Apr 2025 22:13:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBF5UWrxvYgbnxde@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
 <aBE8raTOCVZLfw7J@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBE8raTOCVZLfw7J@x1>

On Tue, Apr 29, 2025 at 05:55:13PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 29, 2025 at 03:59:38AM +0000, Ravi Bangoria wrote:
> > IBS Fetch and IBS Op PMUs has various constraints on supported sample
> > periods. Add perf unit tests to test those.
> > 
> > Running it in parallel with other tests causes intermittent failures.
> > Mark it exclusive to force it to run sequentially. Sample output on a
> > Zen5 machine:
> 
> I've applied the series and will test it now, but found some problems
> when building in some non-glibc systems, namely the use of PAGE_SIZE,
> that is used in libc headers, even in glibc, its just that in glibc we
> happen not to include that header where PAGE_SIZE gets redefined:
> 
> ⬢ [acme@toolbx perf-tools-next]$ grep PAGE_SIZE /usr/include/sys/*.h
> /usr/include/sys/user.h:#define PAGE_SIZE		(1UL << PAGE_SHIFT)
> /usr/include/sys/user.h:#define PAGE_MASK		(~(PAGE_SIZE-1))
> /usr/include/sys/user.h:#define NBPG			PAGE_SIZE
> ⬢ [acme@toolbx perf-tools-next]$
> 
> So I folded the following patch, see if it is acceptable and please ack.
> 
> Thanks for respining it!

Another issue when building with clang on musl:

arch/x86/tests/amd-ibs-period.c:81:3: error: no matching function for call to 'memcpy'
                memcpy(func, insn1, sizeof(insn1));
                ^~~~~~
/usr/include/string.h:27:7: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *' for 1st argument
void *memcpy (void *__restrict, const void *__restrict, size_t);
      ^
/usr/include/fortify/string.h:40:27: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *const' for 1st argument
_FORTIFY_FN(memcpy) void *memcpy(void * _FORTIFY_POS0 __od,
                          ^
arch/x86/tests/amd-ibs-period.c:87:3: error: no matching function for call to 'memcpy'
                memcpy(func, insn2, sizeof(insn2));
                ^~~~~~
/usr/include/string.h:27:7: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *' for 1st argument
void *memcpy (void *__restrict, const void *__restrict, size_t);
      ^
/usr/include/fortify/string.h:40:27: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *const' for 1st argument
_FORTIFY_FN(memcpy) void *memcpy(void * _FORTIFY_POS0 __od,
                          ^
2 errors generated.
  CC      /tmp/build/perf/ui/browsers/header.o
  CC      /tmp/build/perf/arch/x86/util/mem-events.o

Adding the patch below cures it, still need to test on a Zen 5 system.

These issues were just in the regression test.

- Arnaldo

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 946b0a377554fb81..a198434da9b5c4a1 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -78,13 +78,13 @@ static int dummy_workload_1(unsigned long count)
 	else if (count > 10000000)
 		count = 10000000;
 	while (count--) {
-		memcpy(func, insn1, sizeof(insn1));
+		memcpy((void *)func, insn1, sizeof(insn1));
 		if (func() != 1) {
 			pr_debug("ERROR insn1\n");
 			ret = -1;
 			goto out;
 		}
-		memcpy(func, insn2, sizeof(insn2));
+		memcpy((void *)func, insn2, sizeof(insn2));
 		if (func() != 2) {
 			pr_debug("ERROR insn2\n");
 			ret = -1;
