Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47211863E;
	Fri,  6 Jun 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219539; cv=none; b=I+4hp1Zp9o+MQXQL45KNPum1YsytffTkWqhS73HaZDm7NlAZUXgjMyn9n6PBMnzhm8JZkhenFjfzrflEk0Ej5oKNOxGGOy5Kg+qlqOtNEwYqNdrInCIdA4uNhi2ZYDZBKIQfYq+S2t/AxP5EOaMMTrliz00PwgvoM41NMMhzDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219539; c=relaxed/simple;
	bh=pkkL6mHI4nb2yOPPIzaWJ0j+YolfgGRBjMLR/Ejsq4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+VugrtaKAFgzc3sTh0xO2cWFWoIVac7TkBIxGboopEGAMwWmptYC1ydO3XU9iZKvW2FEFo0fd7ENVWAzwmyfo8vmzWiIA3ol3S7AskF75/idkktgcA5nATvP4httrxNbWk2aVpnAQeGod7frj/q82Fm/VkqAcm647y4npdoTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1iVkK0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1iVkK0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F6C4CEEB;
	Fri,  6 Jun 2025 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749219539;
	bh=pkkL6mHI4nb2yOPPIzaWJ0j+YolfgGRBjMLR/Ejsq4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1iVkK0L7Ccl0msF0tGTZuRrE0YFQXXe2rKPaZuw5DZ2YNA+a+kUq7Eq8qTdm+mnK
	 TUDRDRhqGdVRkT/3RGndJ+nau61as9MGRgXpagFiyu0+2LicgiTrZs3nM6GYd5d9rS
	 JBCIv4OXDINGrbCYKC44oGkzGCewPxGLzi1AfGAdSGS3WPvpeRImIgeJnWkEXoirVW
	 5djXzYxSQTlNAUt3/60Kg18rYdbzah5FShiuC+RQhD/npg/Uibembo3fxvM7OEVKh+
	 ucDO4f3PMzVzoPE88njq5syfEKtRFjeePyv1JshnTawAkYDSGkji3qKooQxlwWlGgK
	 et2VhhKkPV1Zg==
Date: Fri, 6 Jun 2025 09:18:57 -0500
From: Rob Herring <robh@kernel.org>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: devicetree@vger.kernel.org, jonathan.cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, krzk@kernel.org,
	dianders@chromium.org, catalin.marinas@arm.com,
	suzuki.poulose@arm.com, mike.leach@linaro.org,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org, gshan@redhat.com, ruanjinjie@huawei.com,
	saravanak@google.com
Subject: Re: [PATCH v3 7/7] of: of_cpu_phandle_to_id to support SMT threads
Message-ID: <20250606141857.GA1476878-robh@kernel.org>
References: <20250512080715.82-1-alireza.sanaee@huawei.com>
 <20250512080715.82-8-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512080715.82-8-alireza.sanaee@huawei.com>

On Mon, May 12, 2025 at 09:07:15AM +0100, Alireza Sanaee wrote:
> Enhance the API to support SMT threads, this will allow sharing
> resources among multiple SMT threads.
> 
> Enabled the sharing of resources, such as L1 Cache and clocks, between
> SMT threads. It introduces a fix that uses thread IDs to match each CPU
> thread in the register array within the cpu-node. This ensures that the
> cpu-map or any driver relying on this API is fine even when SMT threads
> share resources.
> 
> Additionally, I have tested this for CPU based on the discussions in
> [1], I adopted the new cpu-map layout, where the first parameter is a
> phandle and the second is the local thread index, as shown below:
> 
>     core0 {
>       thread0 {
>         cpu = <&cpu0 0>;
>       };
>       thread1 {
>         cpu = <&cpu0 1>;
>       };

I think the thread nodes should be omitted in this case.

>     };
> 
> Also, there are devices such as below that are a bit different.
> 
>     arm_dsu@0 {
>       compatible = "arm,dsu";
>       cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
>     }
> 
> In these cases, we can also point to a CPU thread as well like the
> following:
> 
>     arm_dsu@0 {
>       compatible = "arm,dsu";
>         cpus = <&cpu0 5 &cpu1 9 &cpu2 1 &cpu3 0>;

The purpose of 'cpus' properties is to define CPU affinity. I don't 
think the affinity could ever be different for threads in a core.

And cpu1 having 10 threads is nonsense.

Most cases of 'cpus' (and 'affinity') lookups and then callers of 
of_cpu_node_to_id() ultimately just want to set a cpumask. So we should 
provide that rather than opencoding the same loop everywhere.

>     }
> 
> It should be possible to know how many arguments a phandle might
> require, and this information is encoded in another variable in the dt
> called #cpu-cells in cpu node.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> 
> [1] https://lore.kernel.org/devicetree-spec/CAL_JsqK1yqRLD9B+G7UUp=D8K++mXHq0Rmv=1i6DL_jXyZwXAw@mail.gmail.com/
> ---
>  drivers/of/cpu.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/of/cpu.c b/drivers/of/cpu.c
> index fba17994fc20..cf54ef47f029 100644
> --- a/drivers/of/cpu.c
> +++ b/drivers/of/cpu.c
> @@ -189,16 +189,41 @@ int of_cpu_phandle_to_id(const struct device_node *node,
>  			 struct device_node **cpu_np,
>  			 uint8_t cpu_idx)
>  {
> +	bool found = false;
> +	int cpu, ret = -1, i, j;
> +	uint32_t local_thread, thread_index;
> +	struct device_node *np;
> +	struct of_phandle_args args;
> +	static const char * const phandle_names[] = { "cpus", "cpu" };
> +	static const char * const cpu_cells[] = { "#cpu-cells", NULL };
> +
>  	if (!node)
> -		return -1;
> +		return ret;
>  
> -	*cpu_np = of_parse_phandle(node, "cpu", 0);
> -	if (!*cpu_np)
> -		*cpu_np = of_parse_phandle(node, "cpus", cpu_idx);
> -			if (!*cpu_np)
> -				return -ENODEV;
> +	for (i = 0; i < ARRAY_SIZE(phandle_names); i++) {
> +		for (j = 0; j < ARRAY_SIZE(cpu_cells); j++) {
> +			ret = of_parse_phandle_with_args(node, phandle_names[i],
> +							 cpu_cells[j], cpu_idx,
> +							 &args);
> +				if (ret >= 0)
> +					goto success;
> +		}
> +	}
>  
> -	return of_cpu_node_to_id(*cpu_np);
> +	if (ret < 0)
> +		return ret;
> +success:
> +	*cpu_np = args.np;
> +	thread_index = args.args_count == 1 ? args.args[0] : 0;
> +	for_each_possible_cpu(cpu) {
> +		np = of_get_cpu_node(cpu, &local_thread);
> +		found = (*cpu_np == np) && (local_thread == thread_index);
> +		of_node_put(np);
> +		if (found)
> +			return cpu;
> +	}
> +
> +	return -ENODEV;
>  }
>  EXPORT_SYMBOL(of_cpu_phandle_to_id);
>  
> @@ -206,7 +231,7 @@ EXPORT_SYMBOL(of_cpu_phandle_to_id);
>   * of_get_cpu_state_node - Get CPU's idle state node at the given index
>   *
>   * @cpu_node: The device node for the CPU
> - * @index: The index in the list of the idle states
> +g* @index: The index in the list of the idle states

Oops!

>   *
>   * Two generic methods can be used to describe a CPU's idle states, either via
>   * a flattened description through the "cpu-idle-states" binding or via the
> -- 
> 2.34.1
> 
