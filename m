Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECB548558
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082683; cv=none; b=PJwYp879cGcoFkl2RhSkwPXZmENUHDv2kpQsgGJbRg5de9LRyKWWySr+Qrb19c8qJIytLJnbZPsV08FZqgviMRvJadPp50oYOiJqG3admB9eJp2XuhOTTjCNsEFVnX2WriFxNSh52OWJUvgNcWbbWbHBq/OOzUtGhvU7lk0vCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082683; c=relaxed/simple;
	bh=cSnNPwiN6yk+EOVHl73RfPUomrZtynv9ccjwZPx+lAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo8w5igcGihLQsEgLcJ+2RVKkS4ovFgvxHygohSpwhIXVG1UOK1lioVH89MHJ6GqGLX0nL8gzAKjZwNNaJyQaJG0rq0Nl8DsJ+4Os+BktqoPED1QvT9HYSt/Vx9q5Y4U8MulaKq4hFxGGTK8nUhpuDdMVz6EBCu6mnt6yFcu2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDPHeOGA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDPHeOGA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2946aa0d5aso122599766b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790082679; x=1790687479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jo/W8WDh2FRjK2u86q2opD/F5j1sC7K9OlH5rFnj7t8=;
        b=dDPHeOGAky6GNlctH/fSRLrNObUbNCY+VxtoJeYO8iPfQNX1NjJ8mqXsgnHc/Yzxcs
         zVKub8Hzaw4D/ATtgv8AmqIbrT4134Zz/pHwjKRojhDzp5j7Ya7cG1tcik0vcyiPHUSL
         1nQdUVqj26qGNOfWZelGktqoFRtw7yZuWN+BWzuVnz9Q9GZaIxSK09eLVMyTky3We8Vs
         ElpZ/QDy+D5rOakjC5amYD8KWTVKADjiG3HZFFrDhxaHUifs8lys9+wszgkR9oishDIz
         TZI3phcM+cPBRHl1b+d5bBuvXYvt5aBOESvbAh9lGbBki2SL80712ptzAEBmaimafaPv
         stwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082679; x=1790687479;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jo/W8WDh2FRjK2u86q2opD/F5j1sC7K9OlH5rFnj7t8=;
        b=abEBXkwPitxsjJbb4CZPaHtCLAMOW6pw7gx9F+eSnX9tQzjGK6P28/cOY6MGtZmTOH
         CRVsmdxR7QzkxBLSj0uIpberoh23gOCUu2KHRyuBivFvrtNv2I0ES5CF3ZphxV0s2FBC
         U7miCJ0Oc5sHjMVJN7JHoK/ED1dV7cV7YaayH0BytjAMTaKVuBIjcWfkjrA/W34x2Hoy
         5M6EL/XN+QbHzx9FuHagxEBSjBSW5KYK1gjMuplDGIED8M/KCPdyhayKX9jDfeNF+RWt
         i7Atn5W7fE877v0Pbzmw00GxLo7ql0WNNO0AfsjXmMDXTKXZnoVkg6/l4OsLb0RWeLWQ
         wiDw==
X-Forwarded-Encrypted: i=1; AKwUvBxs6evK+tAXX2e2k2eJACi0MfliLzmH35g6gpGOaCxlTxIpc0P+9NkLHFoIE/GIa7e1PjCNRCX9keDJzBfwYHQB@vger.kernel.org
X-Gm-Message-State: AFuF++koxz5voImboKnUCmbNDljp2tJ6njnUY8eRihASn54W3RDeUCv4
	3U4bsTf9ERbz2g3qAgNZvtT3rhujkGTzqVVDJz8xmX+oKVtHlox48nmn5finyZWIqC0=
X-Gm-Gg: AYBFou1RTicKQxFI0C/P+39SUTx6EkGIesxNaI2dM7XAO7DYhywN3mnWQo+19ZIQnl1
	EUNZEHZ+jDuXla4Cbn0yErlUHngbyb3M4ivb7LkqiZmv5r/CFC3Xq3xxYTFUOsMb/Ucu0to9aqc
	x8l0WOUTgVPZYj8dfF/ZYWJn0wypY3xsLsybPc3bitKghMNvuFKkVeb9c15tAtjhjHyGI7OiQjc
	NmwJWCuqh0NxpkdN97kdu9brA4GLnkh60wH8WVTIzWX5/HDMdIuRCcIEqA/RVLDvO1uMNaDrBB5
	web73JqhA7g3/V7qQjyV011wq+SxKq+xguLiODaX5Eag5x5VjmaWpFUQnU60IAUKlYPHMrL0ADE
	ymvApsuZfzbpHSC5xsgW+97Jc03lOqntb6vPObuk6lCPT6Zgpsk8+J7zTau0xX+c8PiSguNoJTS
	sicGCwr8IKhTd3tmt8dIYC2SX+xQ7NJ3piBp224VRox00L3+UDgvj4U/hOAUM19/MqypKvRuU1Y
	4M=
X-Received: by 2002:a17:907:db02:b0:c26:1f8f:ed53 with SMTP id a640c23a62f3a-c2a8d522b8dmr222772266b.12.1790082679216;
        Tue, 22 Sep 2026 06:11:19 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5832fesm84591366b.30.2026.09.22.06.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:11:18 -0700 (PDT)
Message-ID: <56ea4b35-f73f-4e6e-95e4-f255eb089c5c@linaro.org>
Date: Tue, 22 Sep 2026 14:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/49] perf build: Make mypy build test opt-out
 (NO_MYPY=1)
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev,
 linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com,
 linux-perf-users@vger.kernel.org, namhyung@kernel.org
References: <cover.1789966896.git.irogers@google.com>
 <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/09/2026 06:06, Ian Rogers wrote:
> Commit 168910d0f937 ("perf build: Add mypy build tests") added mypy as an
> opt-in compile-time check (MYPY=1) because of existing mypy errors across
> perf Python scripts.
> 
> Now that all Python scripts in tools/perf have been cleaned up and pass
> mypy without errors, make the mypy build test opt-out (default on when
> mypy is installed, disabled with NO_MYPY=1), matching NO_SHELLCHECK=1.
> Set MYPYPATH to tools/perf/python so local imports resolve during type
> checking, and clean *.mypy_log files in 'make clean'.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Is there some minimum version or other setup requirement? I get this:


pmu-events/amd_metrics.py:181: error: Unsupported operand types for + 
("Event" and "object")  [operator]
pmu-events/amd_metrics.py:182: error: Unsupported operand types for + 
("Event" and "object")  [operator]
pmu-events/amd_metrics.py:230: error: Argument 1 to "d_ratio" has 
incompatible type "object"; expected "int | float | Expression"  [arg-type]
pmu-events/amd_metrics.py:231: error: Unsupported left operand type for 
+ ("object")  [operator]
pmu-events/amd_metrics.py:236: error: Argument 1 to "d_ratio" has 
incompatible type "object"; expected "int | float | Expression"  [arg-type]
pmu-events/amd_metrics.py:236: error: Unsupported left operand type for 
+ ("object")  [operator]
Found 6 errors in 1 file (checked 1 source file)
make[3]: *** [pmu-events/Build:192: 
/home/james/workspace/linux/build/local/pmu-events/amd_metrics.py.mypy_log] 
Error 1
make[2]: *** [Makefile.perf:562: 
/home/james/workspace/linux/build/local/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
python/ilist.py:13: error: Cannot find implementation or library stub 
for module named "textual"  [import-not-found]
python/ilist.py:14: error: Cannot find implementation or library stub 
for module named "textual.app"  [import-not-found]
python/ilist.py:15: error: Cannot find implementation or library stub 
for module named "textual.binding"  [import-not-found]
python/ilist.py:16: error: Cannot find implementation or library stub 
for module named "textual.containers"  [import-not-found]
python/ilist.py:17: error: Cannot find implementation or library stub 
for module named "textual.css.query"  [import-not-found]
python/ilist.py:17: note: See 
https://mypy.readthedocs.io/en/stable/running_mypy.html#missing-imports
python/ilist.py:18: error: Cannot find implementation or library stub 
for module named "textual.command"  [import-not-found]
python/ilist.py:19: error: Cannot find implementation or library stub 
for module named "textual.screen"  [import-not-found]
python/ilist.py:20: error: Cannot find implementation or library stub 
for module named "textual.widgets"  [import-not-found]
python/ilist.py:21: error: Cannot find implementation or library stub 
for module named "textual.widgets.tree"  [import-not-found]
Found 9 errors in 1 file (checked 1 source file)
make[3]: *** [Build:91: 
/home/james/workspace/linux/build/local/python/ilist.py.mypy_log] Error 1
make[3]: *** Waiting for unfinished jobs....
python/treport.py:12: error: Cannot find implementation or library stub 
for module named "textual"  [import-not-found]
python/treport.py:13: error: Cannot find implementation or library stub 
for module named "textual.app"  [import-not-found]
python/treport.py:14: error: Cannot find implementation or library stub 
for module named "textual.binding"  [import-not-found]
python/treport.py:15: error: Cannot find implementation or library stub 
for module named "textual.color"  [import-not-found]
python/treport.py:16: error: Cannot find implementation or library stub 
for module named "textual.scroll_view"  [import-not-found]
python/treport.py:17: error: Cannot find implementation or library stub 
for module named "textual.strip"  [import-not-found]
python/treport.py:18: error: Cannot find implementation or library stub 
for module named "textual.widgets"  [import-not-found]
python/treport.py:19: error: Cannot find implementation or library stub 
for module named "textual.widgets.tree"  [import-not-found]
python/treport.py:19: note: See 
https://mypy.readthedocs.io/en/stable/running_mypy.html#missing-imports
Found 8 errors in 1 file (checked 1 source file)

