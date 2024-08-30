Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA214C5A4;
	Fri, 30 Aug 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013680; cv=none; b=av3ByRhNL026tbGUghMT4iO8sWwsCLX2jrtnfCsL7fkjOB9TT0CtyfW9YMqljTVTlQn/iFqF45GNG2xUva7mYyoZv97xdVegCXHgl/uIsDGHyhdpgUl/ZqGHFU260lKvqxqqDr4ynkBEM3V9JrxW8HeazuOZbjGzVWFYw9wiWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013680; c=relaxed/simple;
	bh=Yf7TTzqcdPtYOl+oh52VZwuRPv7WTGG11QkoJaO64GE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eiJhOJ6Yb0O7XNnY03e8O+ImoSfgkUa3/hEzUnJVhpLa0qlVNsLnoHgHt5EQOSTdBaF3QSDDetx0fd70QIzmyU1bRbg+vwZusmu3ghoNIRxNlFdRo91VIt60kYgPT9wNaDkpxmxXkD6W3/mo8z0jDWW8AguEUcFrEc3BbfCNe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so13880475e9.3;
        Fri, 30 Aug 2024 03:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013677; x=1725618477;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J5Bf+6pEUrFJ0MvxE+vJE80+X4zdiSHPnQRqpGbBj4=;
        b=EkyCkj8Vgqx6GjIpQ6XGITlI0LpMKmZTHWMXjvbwedC9fFAJxrQDrMxyf7xi6kQrdW
         2sq0iQtS8QOt8JSIYf4xXanRoyU/Tuck/53IOYUBwDF1O1AHF0Z4RnbTXR+NHvSAvwI0
         KYuIoG6EL6VHHKj5ZE2sMuknFR7xX2cWsABeq3s8Kd+QmVfC4H21qx5p0duq3M2mpvrP
         mnEAYsK5/vxcgNp/22SBGgBrc/laJ3QPte4HhFPvslJktjJKJVrrBB+JcT4WsilDDtfg
         wi6+f78TGEP7QpFY7d24dSiY8XAP0+od4W/ID0yQQMkL/8KfnGrfFfjK7jx0EwrBwMlY
         eIMg==
X-Forwarded-Encrypted: i=1; AJvYcCWuKVuyfpuLnT4PLQ1TKQb8fDOUKTuAeUB4prrL8QkKn+4arTQWyLkuyfRAccYaLfwb1QtcWPfHEKK+H1zCKTX5OA==@vger.kernel.org, AJvYcCX+6ngHfXNz90T056fnaErMXHY+MwrARy7EfY/A8Ueht73M8zCm3JzYqyELW+PqLtup639FMyRvhIzm1lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVyVJtCUE5Tp8pPEeiCBsWcJl9KLCc3bi9x6aT9gySkh01PZI
	J5KsDiEu7W5ZxQsly+nMwRk7EA1JrMdpDvJ8G7rda+nFLV7qEGWw
X-Google-Smtp-Source: AGHT+IH49J/h0We1vuqLbx5wvw5sOHgwDMkiYeStESeYIGPXlddhGd2MK7dYzFKFfYnfY3PAS0uXzw==
X-Received: by 2002:a05:600c:3596:b0:42b:8a35:1ade with SMTP id 5b1f17b1804b1-42bb02d94f0mr47478275e9.27.1725013677051;
        Fri, 30 Aug 2024 03:27:57 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db07sm74940325e9.34.2024.08.30.03.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:27:56 -0700 (PDT)
Message-ID: <739001a4-4df1-4dec-a141-926c78c5c07e@kernel.org>
Date: Fri, 30 Aug 2024 12:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] perf trace: Fix iteration of syscall ids in
 syscalltbl->entries
From: Jiri Slaby <jirislaby@kernel.org>
To: Howard Chu <howardchu95@gmail.com>, acme@kernel.org
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, namhyung@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 08. 24, 12:24, Jiri Slaby wrote:
>> /usr/lib/gcc/i586-suse-linux/14/../../../../i586-suse-linux/bin/ld: 
>> (.text+0x8154c): undefined reference to `syscalltbl__id_at_idx'
> 
> Should there be something like a function returning identity mapping for 
> !HAVE_SYSCALL_TABLE_SUPPORT?

Something like:
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -178,6 +178,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const 
char *name)
         return audit_name_to_syscall(name, tbl->audit_machine);
  }

+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
+{
+       return idx;
+}
+
  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
                                   const char *syscall_glob 
__maybe_unused, int *idx __maybe_unused)
  {

?

> thanks,-- 
js

