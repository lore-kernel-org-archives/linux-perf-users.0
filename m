Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CB18021
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peQs5xPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C8C433C8;
	Fri, 10 Nov 2023 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699626720;
	bh=1JPm+tl+rvcBUxGJrgvWhapNCbWn2Fq4UXM5qI/FF/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peQs5xPKVUb3DlGM2+C1KHbPfRVZEB7lJ0VXuKt2X6mJmv1+p1zhxyQDDcmN3FK9p
	 7xnE8hO1YAFOHuIy5hftqw1tyhjHSM69mB4z8mxnpQCodIvFKDQFYscWum3U3NVITN
	 W6SLlxyIxf8JEHf3ejWhAKFjkKnJfS72WcjDGgeNx4zyX14FtNIZ61pVeDIwhNAUnU
	 oYc1/H0dBcrzjNyWJjJj1RMb3AyxtQKjgItv7EqUtNHf5335HJJr+tupIPW63jMQVV
	 6x/T/7eeamBrzF7Y0BEaUM6cSmWZYbB1XHa4L33MdGW+2pWSA8Gxu/Q9jNbf1kwjod
	 dTbSV6TcJ2qMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0478E40094; Fri, 10 Nov 2023 11:31:56 -0300 (-03)
Date: Fri, 10 Nov 2023 11:31:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <ZU4+3HxUMg7hW52e@kernel.org>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
 <ZU493oMRpGgNBrQV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU493oMRpGgNBrQV@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
 
> Right after applying this first patch:
 
> [acme@quaco perf-tools-next]$ m
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
>    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
>       |                                                        ^
> builtin-check.c:29:47: note: to match this ‘{’
>    29 | struct feature_support supported_features[] = {
>       |                                               ^
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:242: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

It was a simple error, please be more careful next time.

I'm testing the rest of the patchset now.

- Arnaldo

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 1183983e4352798d..1502804780507b5d 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -50,7 +50,7 @@ struct feature_support supported_features[] = {
 	FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
 	FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
 	FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
-	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
+	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
 
 	/* this should remain at end, to know the array end */
 	FEATURE_SUPPORT(NULL, _)
