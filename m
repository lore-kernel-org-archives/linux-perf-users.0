Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8010F1;
	Wed, 13 Nov 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456772; cv=none; b=Ea7rwHRJ+MutmmtbBqMvL9xMTIjMVfWd2JrQ6YdnMFFqQfn5ByAVrexrlLkJ6Lpw2B1+ywQvYXNlCRIp3xtanu6lTvdG9YoK1Il4oL1SigWQlu55fm4g9LV3aXSgfetXll7hUkOCO3qUq4WaY+29tHi8iPQioOrhkLg6/Ggys0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456772; c=relaxed/simple;
	bh=JnqsIbem2Hrb1bZycnJeMQmKrzpjTjKWlj3diEG/YV4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VTc1okAYxBYI8h9IglJDdvbsIN27fxRtQ1ReX4zODVoHWXdj3089Xr6HymGLjxgom7r5aTP+1M3LpEbbBaT4Llx+MuUMnNo+YQuhloHzm3QjUdvXizzDRPxRnQvI5xIV2YCsXB/G8fiuuRjXeH5Cp9ol5YyROjAMTvUGy+V/w7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4eLaRKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4eLaRKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B68EC4CECD;
	Wed, 13 Nov 2024 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731456771;
	bh=JnqsIbem2Hrb1bZycnJeMQmKrzpjTjKWlj3diEG/YV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P4eLaRKSWK6sVtHwoVOveQDEL4acNmoEMao53uPkIffGraoC6QyVzb4KKY3eIcz2c
	 hqaEp6dP7/KJPx58z6fuibPS6Lj1Y7NjLQTuX7lZAx7PzSD5+BvgzBe3Q0tj6x3WDZ
	 bgm4Ack64RFAea396lHNHCEed8iergL1A82x97p4l2axT+B0ALQG+xyvEqISLIUWjo
	 oUhbj6rf223jHp3ZREF0gdxPxP1s10bkF5hc5UjRb3rsO+b1K3arwq7D38qDp9ycUn
	 OPnAP10tfJFwrf56bAQgMI0P32h32Jkv62dJ+XyBZyeujhvsnEOFtEiiBLmFxryJyN
	 YvEmrxljkzN7w==
Date: Wed, 13 Nov 2024 09:12:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu (Google)
 <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf-probe: Replace unacceptable characters when
 generating event name
Message-Id: <20241113091248.7eaad7dd00ed5714c7216355@kernel.org>
In-Reply-To: <20241113083847.447deb4eeea33afe7bd068be@kernel.org>
References: <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
	<173099117811.2431889.17590362733353379842.stgit@mhiramat.roam.corp.google.com>
	<ZzOQV3Og0UcO05J1@x1>
	<20241113083847.447deb4eeea33afe7bd068be@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

On Wed, 13 Nov 2024 08:38:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Nov 2024 14:28:55 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > On Thu, Nov 07, 2024 at 11:52:58PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > This last patch isn't applying, to make progress I appled 1-5, please
> > take a look at the tmp.perf-tools-next branch at:
> > 
> 
> OK, let me resend on top of that branch.
> 
> Thank you!
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> > 

It seems that this branch can not be compiled without below patch.
(in LIBCAPSTONE=n but LIBLLVM=y case.)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index df6c172c9c7f..88f71f6e5e70 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1422,14 +1422,14 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	free(buf);
 	return NULL;
 }
-#else // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+#endif // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+
 static void symbol__disassembler_missing(const char *disassembler, const char *filename,
 					 struct symbol *sym)
 {
 	pr_debug("The %s disassembler isn't linked in for %s in %s\n",
 		 disassembler, sym->name, filename);
 }
-#endif
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
@@ -1724,7 +1724,8 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 }
 #else // HAVE_LIBCAPSTONE_SUPPORT
 static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
-					struct annotate_args *args)
+					struct annotate_args *args __maybe_unused)
+{
 	symbol__disassembler_missing("capstone", filename, sym);
 	return -1;
 }

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
