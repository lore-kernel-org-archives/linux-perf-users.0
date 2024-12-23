Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467181B86CC;
	Mon, 23 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971621; cv=none; b=IUwK28/yk53D8vDOADUGujWMNNYVUS/e0yQTDhobQdXaV7YKsUJViVJSSCVAsGI8soNbhxl0+MDd+kleu9EksAxIsghJ/Vw7T42B7b/adGTWw/LCq4XFRTlwl8cjKKiW0E2KZOgSM8JLvmhjjIPVm4H/5hD2B7Ad5UQTLAb49ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971621; c=relaxed/simple;
	bh=17rVlQwf4XR80Oud5cWztwTZKX7iBRXF/AokYsu4ZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO4ozPkq4JsafkEt6XiE5HZ9a63wtPrLfIJ43T/cBhBMUvcSXK9mWZAawB6p3Vu8cURTf4hgmiyxu73PGMVRTo2OuDLehWgEjAoRPzc88vGEPQphbcz5bq3hY9MREQYfw2NhGd7M6NMH2iJq5qF8criKMmhNQfgsBFJeAQk0ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5rRY8ow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5rRY8ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAF5C4CED3;
	Mon, 23 Dec 2024 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734971620;
	bh=17rVlQwf4XR80Oud5cWztwTZKX7iBRXF/AokYsu4ZUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5rRY8ow4QACbYk15jqOZreXFbTKR4bVDLo21UUM8T+VpildkufPClH9CInRIww51
	 mSzUM8lGRQpKtHREuc58kiVk3+LUeRlPXsU795aKxbhaj2ozZJHGIHQKwOwOaklywp
	 IujR0sWVIB7HMgiWBlbWG3xxCmfQ48wCGNtScTIcZjV7D7F18qQjqzmIYoL3RTxZV7
	 C0XlZqhKyIszzM1pC6X32jiwcUscF3Ptt3PlYp44T4JXi1C+EwL0UQ17AkJLBFJL8C
	 tCtkDCD0k+WQyCS0zFQwI8s5Rqfi9IGtTeOL3vWXYvtYq8O0WTEj4DD85qiIY3i92p
	 xw0C7iHTeoaAA==
Date: Mon, 23 Dec 2024 13:33:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux@treblig.org
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused is_executable_file
Message-ID: <Z2mQ4RdSE_EfbGyO@x1>
References: <20241222215831.283248-1-linux@treblig.org>
 <Z2mQjAIwBcx4_Pm0@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2mQjAIwBcx4_Pm0@x1>

On Mon, Dec 23, 2024 at 01:32:15PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Dec 22, 2024 at 09:58:31PM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > is_executable_file()  has been unused since 2022's
> > commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")
> > 
> > Remove it.
> 
> Did you patch this on:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
> 
> ?
> 
> That function is still there, so I'll fixup your patch, keep your
> credits and test it all.

FYI, it fails on the .h file:

⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
patching file tools/perf/util/path.c
Hunk #1 succeeded at 77 (offset 10 lines).
patching file tools/perf/util/path.h
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/path.h.rej
⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 9712466c51e2f30e..2e62f272fda8671a 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -77,15 +77,3 @@ bool is_directory_at(int dir_fd, const char *path)
 
        return S_ISDIR(st.st_mode);
 }
-
-bool is_executable_file(const char *base_path, const struct dirent *dent)
-{
-       char path[PATH_MAX];
-       struct stat st;
-
-       snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
-       if (stat(path, &st))
-               return false;
-
-       return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
-}
⬢ [acme@toolbox perf-tools-next]$

⬢ [acme@toolbox perf-tools-next]$ cat tools/perf/util/path.h.rej
--- tools/perf/util/path.h
+++ tools/perf/util/path.h
@@ -12,6 +12,5 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
-bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
⬢ [acme@toolbox perf-tools-next]$ 

Fixed up, thanks.

- Arnaldo
