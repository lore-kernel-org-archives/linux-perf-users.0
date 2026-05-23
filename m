Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F91175A8B;
	Sat, 23 May 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779561707; cv=none; b=lirKKc7sWAq0LwyEtalsAlW27hqwB2C18eJZXHoQRjejVmncrN76oYlX913HKbIZ7sLDxCJRZjPJ4Y6voAwsT0oY0Sj9qnWugpGKKQYcKJu7WUNi/YOLrrH3Efnq1qA+yCJKxxB5zReTF+Jli2/I42D2KnL6UVaew+ymClNvLCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779561707; c=relaxed/simple;
	bh=74hd6cMtKR2LHGwKWSrEj77mPLq3W+6bQ2fUtrOUKcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgZKufkxZssapV+FrRDpbFamfRd7+TkoZMWu1pNyfOnE9gDxMwlJZHm+QylGqiS+eg+AFpR3KeXOyEbIO3eA5dhMgRiiJR7Qu4hGYCahX72PGGWXyE8Q1EyD//g4W7OvwfkC/IHSR0e1niG+nYagbTTHTVbY6uJRLdpssWKl3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from [198.18.0.1] (unknown [113.227.3.159])
	by APP-05 (Coremail) with SMTP id zQCowAB3BwvV9BFq6mFAEQ--.13013S2;
	Sun, 24 May 2026 02:41:26 +0800 (CST)
Message-ID: <6f54fc06-1a75-4910-82a5-172a42f34284@isrc.iscas.ac.cn>
Date: Sun, 24 May 2026 02:41:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf riscv: Fix discarded const qualifier in
 _get_field()
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, palmer@dabbelt.com,
 pjw@kernel.org, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
 <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
From: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAB3BwvV9BFq6mFAEQ--.13013S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8CF45urW3WFW7Cr4xXrb_yoW8Ar1rpr
	Z7Crs0k345Xw15C340vFW29FWUurs3Xaya9F4rA347Zrs8Gw1rtr4ftanxK3ZrXryUCr18
	ur13ury8Aw48AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07betCcUUUUU=
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

Hi Arnaldo, Namhyung,

Just a gentle ping on this patch. It has received a Reviewed-by from Ian.
Could you please consider picking it up for perf-tools-next?

Thanks,
Li Guan

On 5/14/2026 2:07 AM, Li Guan wrote:
> The assignment of strrchr() return values to non-const char * variables
> triggers a -Werror=discarded-qualifiers warning when building with GCC 14.
> This happens because in newer glibc versions, strrchr() returns a
> const char * if the input string is const.
>
> Properly declare 'line2' and 'nl' as const char * to match the glibc
> function signature and ensure type safety. This avoids the need for
> explicit type casting and aligns with the design pattern of not
> modifying read-only memory in the perf tool.
>
> Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> ---
> v2:
>   - Drop the auxtrace decoupling and weak stub approach as they interfered
>     with the cross-platform analysis intent, per Ian's feedback.
>   - Focus on a clean fix for the const qualifier issue in RISC-V header.c
>     by properly declaring local variables as const.
>   - Use Li Guan as the preferred name format for consistency.
>   - Verified that this fix is not yet present in acme/perf-tools-next.
>
>   tools/perf/arch/riscv/util/header.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
> index 4b839203d4..891984e909 100644
> --- a/tools/perf/arch/riscv/util/header.c
> +++ b/tools/perf/arch/riscv/util/header.c
> @@ -19,7 +19,7 @@
>   
>   static char *_get_field(const char *line)
>   {
> -	char *line2, *nl;
> +	const char *line2, *nl;
>   
>   	line2 = strrchr(line, ' ');
>   	if (!line2)

