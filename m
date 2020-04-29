From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v7 3/5] powerpc/hv-24x7: Add sysfs files inside hv-24x7
 device to show processor details
Date: Wed, 29 Apr 2020 14:38:58 +0530
Message-ID: <f4e8fcfd-7147-e463-36d8-7e922f63b6bd@linux.ibm.com>
References: <20200327063642.26175-1-kjain@linux.ibm.com>
 <20200327063642.26175-4-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200327063642.26175-4-kjain@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 3/27/20 12:06 PM, Kajol Jain wrote:
> To expose the system dependent parameter like total number of
> sockets and numbers of chips per socket, patch adds two sysfs files.
> "sockets" and "chips" are added to /sys/devices/hv_24x7/interface/
> of the "hv_24x7" pmu.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 9ae00f29bd21..a31bd5b88f7a 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -454,6 +454,20 @@ static ssize_t device_show_string(struct device *dev,
>   	return sprintf(buf, "%s\n", (char *)d->var);
>   }
>
> +#ifdef CONFIG_PPC_RTAS
> +static ssize_t sockets_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", physsockets);
> +}
> +
> +static ssize_t chips_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	return sprintf(buf, "%d\n", physchips);
> +}
> +#endif
> +

rtas call gives you the cores per chip too. We can expose that
also with this patch?  I understand tool side patchset is using
only metrics added to socket/chip information, its better to
include that cores also here..

>   static struct attribute *device_str_attr_create_(char *name, char *str)
>   {
>   	struct dev_ext_attribute *attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> @@ -1100,6 +1114,10 @@ PAGE_0_ATTR(catalog_len, "%lld\n",
>   		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
>   static BIN_ATTR_RO(catalog, 0/* real length varies */);
>   static DEVICE_ATTR_RO(domains);
> +#ifdef CONFIG_PPC_RTAS
> +static DEVICE_ATTR_RO(sockets);
> +static DEVICE_ATTR_RO(chips);
> +#endif
>
>   static struct bin_attribute *if_bin_attrs[] = {
>   	&bin_attr_catalog,
> @@ -1110,6 +1128,10 @@ static struct attribute *if_attrs[] = {
>   	&dev_attr_catalog_len.attr,
>   	&dev_attr_catalog_version.attr,
>   	&dev_attr_domains.attr,
> +#ifdef CONFIG_PPC_RTAS
> +	&dev_attr_sockets.attr,
> +	&dev_attr_chips.attr,
> +#endif
>   	NULL,
>   };
>
