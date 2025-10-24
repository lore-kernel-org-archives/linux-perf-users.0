Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B513C695;
	Fri, 24 Oct 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321051; cv=none; b=Hp9Vn/qjvUkgD4r53nSgSki+7ELAWEICfZ6RwRUmXh65P5vtNXUBFarU6cvQ4h7X+MaRvZC5usAL/yG050YjxfnKERDlljXPct0pjLFSX1jiT6rbqYKIESA/ncIxYGMoGPJma+entYE0CzMQkeIqz8uR/jdRlgl5BIn+bF63nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321051; c=relaxed/simple;
	bh=caJsNtgZ4UnTHpwxb1JsZHxyp481OSCnnMZxp4OUvI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5DeHmklsBi9l7TUxbj2ma8xGcaNt9B3EaiVXQkBflOYHOns0/ZUqIWe7OAie6PargzkoFT6ALPdLVx34OTgr1qOuF+jkJz2lt9vuKMCnAmhISRvuGOyEW1Nikcy9UR9Y8+5zOBEC6ktCNfPX+U7AOjhvQU4atBW8w/1dbFo57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNEKdlpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNEKdlpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C31C4CEF1;
	Fri, 24 Oct 2025 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321051;
	bh=caJsNtgZ4UnTHpwxb1JsZHxyp481OSCnnMZxp4OUvI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BNEKdlpaH0GMmuWzImYsHZ+SBCAOj9GpB+X/JuEmYSiFjTt90a7naRsqQS89O/wPt
	 72tfuVPoz4demRI0EbmGvGtKYrAj3tuudV7oJ3NVh8pPCP47HVuxkGTXFf/VjOHRlv
	 rUfusps+FwYwqbcxnGHP6so6tJAFvgqK2/jBfBAoqgfi35tHAxYzlF7pyiImwAp8Fo
	 TL5qgTvJid+KjZP3oGV+0g4mfyk7YChJa9JcwSjC7DEy1oh89opcQ5tOuGrH3qvpBt
	 gpeYlAgL8cL1AuxwPMtsVW9KqWB0Ym6270gWt/PpBnL3w7W5mZ3qv0I29hGWGrWt2/
	 NXgx3nX9E8Bcg==
Message-ID: <71fd8843-0a41-40b3-9cbe-dc3f7f77260d@kernel.org>
Date: Fri, 24 Oct 2025 17:50:45 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible string
 for i.MX8QM, i.MX8QXP and i.MX8DXL
To: Frank Li <Frank.li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
 <20251023-qm_dts-v1-1-9830d6a45939@nxp.com>
 <fbef6d02-74e8-4550-81af-afe7ac4c989b@kernel.org>
 <aPt8/exvRPlP0iNl@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aPt8/exvRPlP0iNl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2025 15:19, Frank Li wrote:
> On Fri, Oct 24, 2025 at 03:03:10PM +0200, Krzysztof Kozlowski wrote:
>> On 23/10/2025 20:56, Frank Li wrote:
>>> Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu and
>>> fsl,imx8dxl-db-pmu (for data bus fabric).
>>>
>>> Add clocks and clock-names for fsl,imx8dxl-db-pmu and keep the same
>>> restriction for existing compatible strings.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 26 ++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>>> index d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a..13eb13a79e2100ae1d747ddf6fc4db5b470112a8 100644
>>> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>>> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>>> @@ -14,6 +14,7 @@ properties:
>>>      oneOf:
>>>        - enum:
>>>            - fsl,imx8-ddr-pmu
>>> +          - fsl,imx8dxl-db-pmu
>>>            - fsl,imx8m-ddr-pmu
>>>            - fsl,imx8mq-ddr-pmu
>>>            - fsl,imx8mm-ddr-pmu
>>> @@ -29,6 +30,8 @@ properties:
>>>            - const: fsl,imx8m-ddr-pmu
>>>        - items:
>>>            - const: fsl,imx8dxl-ddr-pmu
>>> +          - const: fsl,imx8qm-ddr-pmu
>>> +          - const: fsl,imx8qxp-ddr-pmu
>>
>>
>> I don't understand the need for this change, not explained in commit
>> msg. Why do you change 8dxl-ddr?
> 
> I have not change 8dxl-ddr, but add fsl,imx8dxl-db-pmu, which is difference


I talk about this exact hunk. You clearly have list for imx8dxl-ddr-pmu
being modified.

> with fsl,imx8dxl-ddr-pmu. (db vs ddr). db have less events compared to
> ddr's pmu.
> 
> Frank
> 
>>
>> Best regards,
>> Krzysztof


Best regards,
Krzysztof
