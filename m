Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068890;
	b=KhCJYDE9w4dgEp+YhB9t9JFAM33V5FyeT3rho0i6n6dUeozvbC41ZmeSIav4pgRd5kja
	 o/cQpEdX9BmV/mFrORMETvQIdqqF8+Fkp/Bxw23Nea0Fg4O7s3BEdrM12wqKb1SOOiRj+
	 ze+CRF+wCX4rKm/P3uu1WY6zJlX5gI0+DGoCqgPbWtSy1FovFW8pafktAhTCtpT9f1XAr
	 xXk3yFhfiRODwRxjqlSKKKPnxCzDPp+K0P/FvE+GW3XWu2zgPyEIzXZkdUxaeGJ609LT/
	 CFsAjrf5ZAAH+b4QFS1bHmJe8hKSuazyi3w6yAVJ8hNZnA1vHZvP7UEpOI4O6QQn2tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=2U680O0znIrDLYboQYSen6VujqaGXN4EQi3ptoV3TXkim4t4y8IHxQ8s8KTLwPlG6x+j
	 U8v4CPcLSU0BlrAUHX50zvU4xd6s/bWNvRGQ4PutB7WNaeJx1W0Xw0uYCuWdrg66bVUbV
	 cXgzUjb2OtnVu2P8GpaHg4hjNHcu88UApwkoS8W7qnoJ5MDQfVtgKPrit2gm34/EfTsBE
	 WcXdLQhW9joNeZGu95huWBRsW6JFA83GoWorgdRKFPVovpyRPhlpLmxKNM/08CrXliEMF
	 ZYGx5mlqbLBdfaNHylg9j5APu8z6OO8k2j4se7VvJk0dEIo30CHC1FbcUpYNSCJtscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65656606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 02:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65656606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4488338c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068884; x=1793673684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=oc6cZqFau/HqROtNMBTq8ZP3TLLLzMKPOdbVxFYEww/DOpOMHzAfKhTORNvN4KTBkp
         LUp5Moi9eFCEYu5/4XDZT8WcjpiPsCN+0zUGPUekQp2yZJY0zBe8yl4kYAkKqjEdTrbQ
         qqNSykJeEwW7qBFZEoQS1rQ+7ZwY381+e8TxKyiv+Q5rLJiCFF4PtyVkTxWHTKQMc6vO
         +lb3qFo71UgGSSnv6IseZ7y8wLhEFz6jBXh4HUpywe8jgXN4FoqKQy7CyAzCO9Yfeytz
         HBIYtHcP3MQ7eijYy79F5eSeZqsN4/+XnIDB6Cna6QVY5R0NQaf50jlOwAuklcgL/mVV
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068884; x=1793673684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=vsOSDg4pODpsYte54JnQ1OSA8K8NQN1qmWnZD5kVDFaYJ4tFVE33FfZCWQnj7jJ3Hh
         mnkACV0zYc9smx9HknO52VbPD6QuE6iez4AWAaCEV17q7EubrLYx8CY7sw5tSus4f4zt
         wfNZTlRedFwYvMLQk5LW58TQ4fqZ2hfgDBOBmu1q5/uMUXWZ3hD+o2GUmOeleuWiEdLB
         nM17RxuC1Ndmr7HoAb7DEl45vse6lAYUzMaJD02cjuG4k/vbh5Nb/sNQqPu3gVAVYl6U
         ZKuq/jxUYn7gAwxUhIIUHGj49SmaV7JcDa9OUgwPGSwYCB6lwJSK4t5gNIuHphA3jE/+
         uhMg==
X-Forwarded-Encrypted: i=1; AKwUvByi45icKi18DVQrlaoDvQZJYZd1k4UXNNmMdri3nGrXDN4XfHCZkAtHDz7b5KIURcjcQmskfqloN24lqrcTo4v4@vger.kernel.org
X-Gm-Message-State: AFq9FYJLE5itPxgJwXG8kOMeJ8UFa2xr6/XXDKbY0sDxKAmg00+r7ps6
	BMBvmS0PgPC3Lu8ooSi90Dhw/JB1rRnVXscxYlXB64c8spsyQW3IEs5xZBVagb2WOU8=
X-Gm-Gg: AYBFou3asp+GJTUOMfhKePp1BUDkSbbN3BwFF6DX8Sssx2+S9WEBZzYOXctcd5bGUVq
	pncLqCio5VtGkyLy1eRp8j/SXWqKnRSX2cZnsF4cx/MSAltqEUq+CTZii89t8G9VGTzldbQAA2f
	0PrwcT+Vhwnv/Sip9Whe6dUeIImlBtisxrcaLa+swYzK216w/MnwTv2xXwrlOue6EUav0StY1cN
	p7xAgoVDRhEBKHtSdSSb3d0hA667ZNPOjBZ2LtoCJUSxNhuKClnESwpCIw9+PKXGkm4Ma5Jz0LV
	tdLuD2bVzK70Cr4Fe+vbaXZJKkW20B/TC7C2i/yt0I05HtG5cj/L9oevOSnZ4+QL4Os5rXHtutt
	JAk26g7FloPMgS0I86ykYs2fg3eW6bdS+yqLBXfmdj84G30A3BYcMmRwLfUtZyzq4AgEXbhCIx5
	DWKjEIMYqbB7gbZBbqekETbDHIIJXv9npQUBRHvhOIeeWOpvDz2LPIg8KXqRY0KYhzsdaDOKVdD
	DIlzd1gf8PN7hM6iZ9t/Dp81jD8PmZsjNcqMzYNs61AbeO46QTCknGOGu9H3LtPtO/cv1UvtSsH
	5iSNzpT86JebKZbVAFTSjfMngcXR5gywQzrGYsI=
X-Received: by 2002:a05:701b:4184:20b0:191:444:425 with SMTP id a92af1059eb24-199290fe40cmr12440066c88.2.1793068884148;
        Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm29293759c88.14.2026.10.26.19.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:41:23 -0700 (PDT)
Message-ID: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
Date: Mon, 26 Oct 2026 20:41:21 -0600
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-2-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

